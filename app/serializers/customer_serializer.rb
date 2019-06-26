class CustomerSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id,
             :last_name,
             :first_name
end
