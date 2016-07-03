defmodule ExJsonSchema.Validator.Error do
  use DiscUnion

  defunion TypeMismatch in expected * got
  # properties
  | AdditionalPropertiesNotAllowed in additional_property

  # dependencies
  | DependencyNotPresent in dependant * dependency

  # items
  | AdditionalItemsNotAllowed in index

  # generic validator
  | NotAllMatched in invalid_indexes
  | NoneMatchedShouldAny
  | NoneMatchedShouldOne
  | TooManyMatchedShouldOne in valid_indexes
  | ShouldNotMatch
  | TooFewProperties in expected * got
  | TooManyProperties in expected * got
  | RequiredNotPresent in property
  | TooFewItems in expected * got
  | TooManyItems in expected * got
  | ItemsNotUnique
  | NotAllowedInEnum in value
  | ShouldBeGreater in minimum
  | ShouldBeGreaterOrEqual in minimum
  | ShouldBeLesser in maximum
  | ShouldBeLesserOrEqual in maximum
  | NotMultipleOf in expected * got
  | TooShort in expected * got
  | TooLong in expected * got
  | PatternNotMatched in string * pattern

  # format
  | NotAnIso8601DateTime in string
  | NotAnEmail in string
  | NotAHostname in string
  | NotAnIpV4 in string
  | NotAnIpV6 in string
end
