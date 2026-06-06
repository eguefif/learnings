class Customer:
    def __init__(self, name):
        self._rentals = []
        self.name = name

    def getName(self):
        return self.name

    def statement(self):
        totalAmount = 0
        frequentRenterPoints = 0

        # Title
        result = "Rental Record for " + self.getName() + "\n"

        # Table
        for rental in self._rentals:
            thisAmount = 0.0

            # determine amounts for each line
            if rental.getMovie().getPriceCode() == Movie.REGULAR:
                thisAmount += 2
                if rental.getDaysRented() > 2:
                    thisAmount += (rental.getDaysRented() - 2) * 1.5
            elif rental.getMovie().getPriceCode() == Movie.NEW_RELEASE:
                thisAmount += rental.getDaysRented() * 3
            elif rental.getMovie().getPriceCode() == Movie.CHILDRENS:
                thisAmount += 1.5
                if rental.getDaysRented() > 3:
                    thisAmount += (rental.getDaysRented() - 3) * 1.5

            # add frequent renter points
            frequentRenterPoints += 1
            # add bonus for a two day new release rental
            if (
                rental.getMovie().getPriceCode() == Movie.NEW_RELEASE
            ) and rental.getDaysRented() > 1:
                frequentRenterPoints += 1

            # show figures for this rental
            result += (
                "\t" + rental.getMovie().getTitle() + "\t" + str(thisAmount) + "\n"
            )
            totalAmount += thisAmount

        # add footer lines: substatements
        result += "Amount owed is " + str(totalAmount) + "\n"
        result += "You earned " + str(frequentRenterPoints) + " frequent renter points"

        return result

    def addRental(self, rental):
        self._rentals.append(rental)


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

    def getDaysRented(self):
        return self.daysRented

    def getMovie(self):
        return self.movie
