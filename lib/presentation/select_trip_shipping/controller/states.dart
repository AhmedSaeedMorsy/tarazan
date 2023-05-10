abstract class SelectTripShippingStates {}

class SelectTripShippingInitStates extends SelectTripShippingStates {}

class ShippingTicketsLoadingState extends SelectTripShippingStates {}

class ShippingTicketsSuccessState extends SelectTripShippingStates {}

class ShippingTicketsErrorState extends SelectTripShippingStates {}

class IncrementAmountState extends SelectTripShippingStates {}

class DecrementAmountState extends SelectTripShippingStates {}

class BookTicketLoadingState extends SelectTripShippingStates {}

class BookTicketSuccessState extends SelectTripShippingStates {}

class BookTicketErrorState extends SelectTripShippingStates {
  BookTicketErrorState();
}
