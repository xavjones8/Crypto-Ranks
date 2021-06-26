# Crypto-Ranks
## I'm creating this application as a way to throw myself into development with Swift so that I can learn more about iOS development and strengthen what I've already learned.
## Outcomes:

- Understand how to use APIs in mobile applications
- Create more complex and modular interfaces
- Strengthen knowledge of the Swift language
- Exercise good programming etiquette.
# Pre-Development Plan

## Models

struct Currency: CustomStringConvertible, Comparable{

var name: String

var symbol: String

var price: Double

var rank: Int

var change: Double

var description: String{

return “(name) has had a percent change of (change) in the last 7 days and is currently sitting at $(price) per share. It’s rank among cryptocurrencies is \(rank).”

}

static func < (lhs: Currency, rhs: Currency) → Bool {

return lhs.rank < rhs.rank

}

}

## Views

### There should be 2 views.

- One storyboard with a collection view that displays the rankings for the currencies. It will respond to touch input to take the user into a detail view.
   - CollectionViewCell to determine the layout for the cells of the collection view.
- Another storyboard that will be presented modally to display details about a currency the user will tap in the collection view.

## Controllers

Collection View Controller - Handles collection view logic and appearance. Handles touch input and sends current currency id to the detail view.

Details View Controller - Receives information from the collection view and displays the currency details.

# Post-Development Lessons
This project filled in so many blanks for me when it comes to implementing APIs and using collection views. I plan on continuing to expand my knowledge of API implementations and asynchronous threads in my next project.

