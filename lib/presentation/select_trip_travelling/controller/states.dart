abstract class SelectTripTravellingStates {}

class SelectTripTravellingInitStates extends SelectTripTravellingStates {}

class TravellingTicketsLoadingState extends SelectTripTravellingStates {}

class TravellingTicketsSuccessState extends SelectTripTravellingStates {}

class TravellingTicketsErrorState extends SelectTripTravellingStates {}

class IncrementNumberOfSeatsState extends SelectTripTravellingStates {}

class DecrementNumberOfSeatsState extends SelectTripTravellingStates {}

class BookTicketLoadingState extends SelectTripTravellingStates {}

class BookTicketSuccessState extends SelectTripTravellingStates {}

class BookTicketErrorState extends SelectTripTravellingStates {
  BookTicketErrorState();
}
