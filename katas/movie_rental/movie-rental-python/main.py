from movie_rental import Customer, Movie, Rental


def run():
    customer = Customer("Bob")
    customer.addRental(Rental(Movie("Jaws", Movie.REGULAR), 2))
    customer.addRental(Rental(Movie("Golden Eye", Movie.REGULAR), 3))
    customer.addRental(Rental(Movie("Short New", Movie.NEW_RELEASE), 1))
    customer.addRental(Rental(Movie("Long New", Movie.NEW_RELEASE), 2))
    customer.addRental(Rental(Movie("Bambi", Movie.CHILDRENS), 3))
    customer.addRental(Rental(Movie("Toy Story", Movie.CHILDRENS), 4))

    print(customer.statement())


def main():
    print("Hello from movie-rental-python!")
    run()


if __name__ == "__main__":
    main()
