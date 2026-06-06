from typing import Literal, TypedDict


class RowContent(TypedDict):
    movieTitle: str
    amount: str


class TitleContent(TypedDict):
    text: str
    name: str


class AmountContent(TypedDict):
    text: str
    amount: str


class PointsContent(TypedDict):
    text: str
    points: str


class StatementContent(TypedDict):
    title: TitleContent
    table: list[RowContent]
    totalAmount: AmountContent
    renterPoints: PointsContent


class Movie:
    CHILDRENS: int = 2
    NEW_RELEASE: int = 1
    REGULAR: int = 0

    def __init__(self, title: str, priceCode: float):
        self.title: str = title
        self.priceCode: float = priceCode

    def getPriceCode(self) -> float:
        return self.priceCode

    def setPriceCode(self, price: float):
        self.priceCode = price

    def getTitle(self) -> str:
        return self.title


class Rental:
    def __init__(self, movie: Movie, daysRented: int):
        self.daysRented: int = daysRented
        self.movie: Movie = movie
        self.amount: float = self._calculateAmount()

    def _calculateAmount(self) -> float:
        thisAmount = 0.0

        # determine amounts for each line
        if self.getMovie().getPriceCode() == Movie.REGULAR:
            thisAmount += 2
            if self.getDaysRented() > 2:
                thisAmount += (self.getDaysRented() - 2) * 1.5
        elif self.getMovie().getPriceCode() == Movie.NEW_RELEASE:
            thisAmount += self.getDaysRented() * 3
        elif self.getMovie().getPriceCode() == Movie.CHILDRENS:
            thisAmount += 1.5
            if self.getDaysRented() > 3:
                thisAmount += (self.getDaysRented() - 3) * 1.5

        return thisAmount

    def getAmount(self) -> float:
        return self.amount

    def getDaysRented(self) -> int:
        return self.daysRented

    def getMovie(self) -> Movie:
        return self.movie


class Customer:
    def __init__(self, name: str):
        self._rentals: list[Rental] = []
        self._totalAmount: float = 0
        self._frequentRenterPoints: int = 0
        self.name: str = name

    def getName(self) -> str:
        return self.name

    def statement(self, method: Literal["rawText", "html"] = "rawText") -> str:
        """Generate a rental statement as a formatted string.

        Args:
            method (str): Output format. One of:
                - "rawText" (default): plain text format.
                - "html": HTML format with tags.

        Returns:
            str: The formatted rental statement.

        Raises:
            Exception: If method is not a recognized format.
        """
        content: StatementContent = self._prepareContent()
        result = self._createStatement(content, method)
        return result

    def _prepareContent(self) -> StatementContent:
        title: TitleContent = {"text": "Rental Record for", "name": self.getName()}

        # Add Table for each movies
        rowContent: list[RowContent] = [
            {
                "movieTitle": rental.getMovie().getTitle(),
                "amount": str(rental.getAmount()),
            }
            for rental in self._rentals
        ]

        # Add footer
        totalAmount: AmountContent = {
            "text": "Amount owed is",
            "amount": str(self._totalAmount),
        }

        renterPoints: PointsContent = {
            "text": "You earned #{point} frequent renter points",
            "points": str(self._frequentRenterPoints),
        }
        content: StatementContent = {
            "title": title,
            "table": rowContent,
            "totalAmount": totalAmount,
            "renterPoints": renterPoints,
        }
        return content

    def _createStatement(
        self, content: StatementContent, method: Literal["rawText", "html"]
    ) -> str:
        match method:
            case "rawText":
                return self._createRawText(content)
            case "html":
                return self._createHtml(content)
            case _:
                raise Exception(f"UnknownMethod: {method}")

    def _createRawText(self, content: StatementContent) -> str:
        result = content["title"]["text"] + " " + content["title"]["name"] + "\n"
        for row in content["table"]:
            result += "\t" + row["movieTitle"] + "\t" + row["amount"] + "\n"
        result += (
            content["totalAmount"]["text"]
            + " "
            + content["totalAmount"]["amount"]
            + "\n"
        )
        result += content["renterPoints"]["text"].replace(
            "#{point}", content["renterPoints"]["points"]
        )
        return result

    def _createHtml(self, content: StatementContent) -> str:
        # TODO: add em for renter's name
        result = (
            "<h1>"
            + content["title"]["text"]
            + " "
            + f"<em>{content['title']['name']}</em>"
            + "</h1>\n"
        )
        result += "<table>\n"
        for row in content["table"]:
            result += (
                "\t<tr><td>"
                + row["movieTitle"]
                + "</td><td>"
                + str(row["amount"])
                + "</td></tr>\n"
            )
        result += "</table>\n"
        result += (
            "<p>"
            + content["totalAmount"]["text"]
            + " "
            + f"<em>{content['totalAmount']['amount']}</em>"
            + "</p>\n"
        )

        result += (
            "<p>"
            + content["renterPoints"]["text"].replace(
                "#{point}", f"<em>{content['renterPoints']['points']}</em>"
            )
            + "</p>"
        )
        return result

    def addRental(self, rental: Rental):
        self._rentals.append(rental)
        self._totalAmount += rental.getAmount()
        # add frequent renter points
        self._frequentRenterPoints += self._calculateRenterPoints(rental)

    def _calculateRenterPoints(self, rental):
        points = 1
        # add bonus for a two day new release rental
        if (
            rental.getMovie().getPriceCode() == Movie.NEW_RELEASE
        ) and rental.getDaysRented() > 1:
            points += 1

        return points
