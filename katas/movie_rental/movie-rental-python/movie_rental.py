class Customer:
    def __init__(self, name):
        self._rentals = []
        self._totalAmount = 0
        self.name = name
        self._frequentRenterPoints = 0

    def getName(self):
        return self.name

    def statement(self, method="rawText"):
        content = {}
        # Title
        content["title"] = "Rental Record for " + self.getName()

        # Table
        content["table"] = []
        for rental in self._rentals:
            row = {}
            row["movieTitle"] = rental.getMovie().getTitle()
            row["amount"] = rental.getAmount()
            content["table"].append(row)
        # add footer lines: substatements
        content["totalAmount"] = "Amount owed is " + str(self._totalAmount)
        content["renterPoints"] = (
            "You earned " + str(self._frequentRenterPoints) + " frequent renter points"
        )
        result = self._createStatement(content, method)
        return result

    def _createStatement(self, content, method):
        match method:
            case "rawText":
                return self._createRawText(content)
            case "html":
                return self._createHtml(content)

    def _createRawText(self, content):
        result = content["title"] + "\n"
        for row in content["table"]:
            result += "\t" + row["movieTitle"] + "\t" + str(row["amount"]) + "\n"
        result += content["totalAmount"] + "\n"
        result += content["renterPoints"]
        return result

    def _createHtml(self, _content):
        return ""

    def addRental(self, rental):
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


class Movie:
    CHILDRENS = 2
    NEW_RELEASE = 1
    REGULAR = 0

    def __init__(self, title, priceCode):
        self.title = title
        self.priceCode = priceCode

    def getPriceCode(self):
        return self.priceCode

    def setPriceCode(self, arg):
        self.priceCode = arg

    def getTitle(self):
        return self.title


class Rental:
    def __init__(self, movie, daysRented):
        self.daysRented = daysRented
        self.movie = movie
        self.amount = self._calculateAmount()

    def _calculateAmount(self):
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

    def getAmount(self):
        return self.amount

    def getDaysRented(self):
        return self.daysRented

    def getMovie(self):
        return self.movie
