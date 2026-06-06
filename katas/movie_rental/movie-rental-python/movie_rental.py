class Customer:
    def __init__(self, name):
        self._rentals = []
        self._totalAmount = 0
        self.name = name

    def getName(self):
        return self.name

    def statement(self):
        frequentRenterPoints = 0

        # Title
        result = "Rental Record for " + self.getName() + "\n"

        # Table
        for rental in self._rentals:
            # add frequent renter points
            frequentRenterPoints += 1
            # add bonus for a two day new release rental
            if (
                rental.getMovie().getPriceCode() == Movie.NEW_RELEASE
            ) and rental.getDaysRented() > 1:
                frequentRenterPoints += 1

            # show figures for this rental
            result += (
                "\t" + rental.getMovie().getTitle() + "\t" + str(rental.amount) + "\n"
            )
        # add footer lines: substatements
        result += "Amount owed is " + str(self._totalAmount) + "\n"
        result += "You earned " + str(frequentRenterPoints) + " frequent renter points"

        return result

    def addRental(self, rental):
        self._rentals.append(rental)
        self._totalAmount += rental.getAmount()


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
