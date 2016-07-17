# exercise14.rb

contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

fields = [:email, :address, :phone]

contacts.each do |name, data|
  fields.each do |key|
    contacts[name][key] = contact_data.first.shift
  end
  contact_data.shift
end
