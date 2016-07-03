defmodule ExJsonSchema.Formatter do
  alias ExJsonSchema.Validator.Error
  require ExJsonSchema.Validator.Error

  def format(errors) do
    errors
    |> Enum.map(fn {err, pointer} ->
      {do_format(err), pointer}
    end)
  end

  defp do_format(err) do
    Error.case err do
      TypeMismatch in expected, got ->
        "Type mismatch. Expected #{expected} but got #{got}."

      # properties
      AdditionalPropertiesNotAllowed in additional_property ->
        "Schema does not allow additional properties: #{inspect additional_property}."

      # dependencies
      DependencyNotPresent in dependant, dependency ->
        "Property #{dependant} depends on #{dependency} to be present but it was not."

      # items
      AdditionalItemsNotAllowed in index ->
        "Schema does not allow additional items at #{index}."

      # generic validator
      NotAllMatched in invalid_indexes ->
        "Expected all of the schemata to match, " <>
          "but the schemata at the following indexes did not: " <>
          "#{Enum.join(invalid_indexes, ", ")}."
      NoneMatchedShouldAny ->
        "Expected any of the schemata to match but none did."
      NoneMatchedShouldOne ->
        "Expected exactly one of the schemata to match, but none of them did."
      TooManyMatchedShouldOne in valid_indexes ->
        "Expected exactly one of the schemata to match, " <>
          "but the schemata at the following indexes did: " <>
          "#{Enum.join(valid_indexes, ", ")}."
      ShouldNotMatch ->
        "Expected schema not to match but it did."
      TooFewProperties in expected, got ->
        "Expected a minimum of #{expected} properties but got #{got}"
      TooManyProperties in expected, got ->
        "Expected a maximum of #{expected} properties but got #{got}"
      RequiredNotPresent in property ->
        "Required property #{property} was not present."
      TooFewItems in expected, got ->
        "Expected a minimum of #{expected} items but got #{got}."
      TooManyItems in expected, got ->
        "Expected a maximum of #{expected} items but got #{got}."
      ItemsNotUnique ->
        "Expected items to be unique but they were not."
      NotAllowedInEnum in value ->
        "Value #{value} is not allowed in enum."
      ShouldBeGreater in minimum ->
        "Expected the value to be greater than #{minimum}"
      ShouldBeGreaterOrEqual in minimum ->
        "Expected the value to be greater or equal to #{minimum}"
      ShouldBeLesser in maximum ->
        "Expected the value to be lesser #{maximum}"
      ShouldBeLesserOrEqual in maximum ->
        "Expected the value to be lesser or equal to #{maximum}"
      NotMultipleOf in expected, got ->
        "Expected value to be a multiple of #{expected} but got #{got}."
      TooShort in expected, got ->
        "Expected value to have a minimum length of #{expected} but was #{got}."
      TooLong in expected, got ->
        "Expected value to have a maximum length of #{expected} but was #{got}."
      PatternNotMatched in string, pattern ->
        "String #{string} does not match pattern #{pattern}."

      # format
      NotAnIso8601DateTime in string ->
        "Expected #{string} to be a valid ISO 8601 date-time."
      NotAnEmail in string ->
        "Expected #{string} to be an email address."
      NotAHostname in string ->
        "Expected #{string} to be a host name."
      NotAnIpV4 in string ->
        "Expected #{string} to be an IPv4 address."
      NotAnIpV6 in string ->
        "Expected #{string} to be an IPv4 address."
    end
  end
end
