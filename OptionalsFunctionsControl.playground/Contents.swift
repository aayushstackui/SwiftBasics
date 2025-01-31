import UIKit

//optional
struct Movie {
    let title: String
    let seatavailability : Int?
}

func checkSeatAvailability(for movie: Movie){
    if let seats = movie.seatavailability {
        print("The movie is '\(movie.title)' has '\(seats)' seats available")
    }
}

let movie1 = Movie(title: "Flipped", seatavailability: 0)
let movie2 = Movie(title: "Real Steel", seatavailability: 6)

checkSeatAvailability(for: movie1)
checkSeatAvailability(for: movie2)

//functional
//basic function
func hellouser(){
    print("Welcome to the Movie Booking!")
}

hellouser()

//function with parameteres

func ticketbooking(movieName: String, seat : Int){
    print("Your tickets for the movie \(movieName) is for the available seats of \(seat)")
}

ticketbooking(movieName: "Flipped", seat: 12)

//function with returning values
func calculatePrice(ticket: Int, perTicket: Double) -> Double {
    return Double (ticket) * perTicket
}
let totalPrice = calculatePrice(ticket: 5, perTicket: 15.99)
print("Price of the ticket is \(totalPrice)")

//funciton with default parameter
func chooseSeatType(seatType: String = "Deluxe"){
    print("You have selected a \(seatType) seat.")
}
chooseSeatType()

//function to inout parameter
func bookTickets(availableSeats: inout Int, ticketsToBook: Int){
    availableSeats -= ticketsToBook
}

var seats = 10
print("seasts before booking: \(seats)")
bookTickets(availableSeats: &seats, ticketsToBook: 3)
print("Seats after booking: \(seats)")

//tuples
let movieDetails = (title: "Batman", seatsAvailable: 14)
print("Movie Title: \(movieDetails.title)")
print("Seats Available: \(movieDetails.seatsAvailable)")

//control statements
func movieBooking(availableSeats: Int?, requestSeats: Int) {
    if let seats = availableSeats {
        if requestSeats <= seats {
            print("Done! You have booked \(requestSeats) seats.")
        } else {
            print("Sorry, Only \(seats) are open.")
        }
    } else {
        print("Available seats are unknown.")
    }
}
movieBooking(availableSeats: 8, requestSeats: 8)
movieBooking(availableSeats: nil, requestSeats: 2)
movieBooking(availableSeats: 2, requestSeats: 5)

func getMovieCategory(for age: Int){
    switch age{
    case 0...14:
        print("Kid's movies are available")
    case 14...22:
        print("Teen movies are available")
    case 22...:
        print("Adult movies are available")
    default :
        print("Wrong age")
    }
}

getMovieCategory(for: 5)
getMovieCategory(for: 16)
getMovieCategory(for: 56)
getMovieCategory(for: -29)
