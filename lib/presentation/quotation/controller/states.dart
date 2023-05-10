abstract class QuotationStates {}

class QuotationInitState extends QuotationStates {}

class QuotationLoadingState extends QuotationStates {}

class QuotationSuccessState extends QuotationStates {}

class QuotationErrorState extends QuotationStates {}

class AllowQuotationLoadingState extends QuotationStates {}

class AllowQuotationSuccessState extends QuotationStates {}

class AllowQuotationErrorState extends QuotationStates {}

class DenyQuotationLoadingState extends QuotationStates {}

class DenyQuotationSuccessState extends QuotationStates {}

class DenyQuotationErrorState extends QuotationStates {}
