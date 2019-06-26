class CustomerSerializer
  include FastJsonapi::ObjectSerializer

  attributes :last_name,
             :first_name
end
