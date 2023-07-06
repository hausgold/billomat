# Client/Customer

Documentation exists in English (1) and German (2). Both cover the client as well as contacts. The German version also covers user defined fields (Attribute) and tags (Schlagwörter). If you can try to fallow the German documentation since it is more complete than the English version. The documentation shows the method (get, put, post, delete) and the path and query parameters beyond the base URL as well as some of the parameters the URL takes. All examples are in XML and often are escaped. To read the code you will need to unescape the examples.

All examples here will be shown once in CURL and JSON and once using the Billomat Gem. If you replace <your-billomat-api-key> and <your-billomat-subdomain> with the correct values you should be able to use the fallowing curl commands.

## List

The per_page value defaults to 100, the page value to 1.

``` BASH
curl -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/clients\?per_page\=2\&page\=1
```

The returned data is a nested object, clients.client contains an array of all the returned client objects. If there is only one clients.client is an object. There is code in utils.rs to handle this case.

``` JSON
{
  "clients": {
    "client": [],
    "@page": "1",
    "@per_page": "2",
    "@total": "12"
  }
}
```

In ruby you have two ways to get at the list data. The first is to call the list function (page and per_page optional) and the second ist to call paged_list (again with page and per_page optional). Each give back slightly different data.

``` RUBY
clients = Billomat::Models::Client.list
clients.each do |client|
  pp client.data
end
```

list returns a list of Billomat::Models::Client. To get at the date call the data property.

``` RUBY
clients = Billomat::Models::Client.paged_list(page = 2, per_page = 10)
pp clients
```

paged_list returns a hash whith two properties, data wich contains the same data as list does and paging_data, a hash that has page, per_page and total as properties.

## Filter

You can filter by attribute, in this case the client_number attribute.

``` BASH
curl -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/clients\?client_number\=KD2
```

Or you can filter by a user defined field by using "property\#\{client_property_id\}" as attribute.

``` BASH
curl -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/clients\?property18280\=649062cae817b347c8780fb5
```

In ruby you can filter by calling the where method on the resource.

``` RUBY
clients = Billomat::Models::Client.where({"client_number": "KD2"})
```

## Create

Lets create an client by sending the fallowing JSON to the API.

``` JSON
{
  "client": {
    "name": "Test Company",
    "first_name": "Tara",
    "last_name": "Testarossa",
    "street": "Via Ticino 6",
    "city": "Turin",
    "country_code": "IT"
  }
}
```

We do that by posting the data like this:

``` BASH
curl -X POST -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' -H 'Content-Type: application/json' -d '{"client":{"name":"Test Company","first_name":"Tara","last_name":"Testarossa","street":"Via Ticino 6","city":"Turin","country_code":"IT"}}' https://<your-billomat-subdomain>.billomat.net/api/clients
```

The return data is the resulting client. The same can be achieved over in ruby like this:

``` RUBY
client = Billomat::Models::Client.new({
  "name" => "Test Company",
  "first_name" => "Tara",
  "last_name" => "Testarossa",
  "street" => "Via Ticino 6",
  "city" => "Turin",
  "country_code" => "IT"
})
client.save
```

The return data will be pushed to client.data.

## Update

Lets update a client.

``` JSON
{
  "client": {
    "street": "Via Ticino 1"
  }
}
```

By putting the changed data to the API.

``` BASH
curl -X PUT -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' -H 'Content-Type: application/json' -d '{"client":{"street":"Via Ticino 1"}}' https://<your-billomat-subdomain>.billomat.net/api/clients/7299528
```

The same can be done in ruby by instantiating a client with ID and saving.

``` RUBY
client = Billomat::Models::Client.new('id' => 7299528, 'street' => 'Via Ticino 2')
client.save
```

The save method is a switch that calls the update method if an id is set and create if not.

## Delete

You can delete a client like this: 

``` BASH
curl -X DELETE -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/clients/7272454
```

Using the gem the same can be achieved by:

``` RUBY
client = Billomat::Models::Client.new('id' => 7272453)
client.delete
```

## Contacts

Documentation for contacts exists in English (3) and German (4).

### List

The per_page value defaults to 100, the page value to 1.

``` BASH
curl -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/contacts\?per_page\=2\&page\=1
```

The returned data is a nested object, contacts.contact contains an array of all the returned contact objects. If there is only one contacts.contact is an object. There is code in utils.rs to handle this case.

``` JSON
{
  "contacts": {
    "contact": [],
    "@page": "1",
    "@per_page": "2",
    "@total": "2"
  }
}
```

In ruby you have two ways to get at the list data. The first is to call the list function (page and per_page optional) and the second ist to call paged_list (again with page and per_page optional). Each give back slightly different data.

``` RUBY
contacts = Billomat::Models::Contact.list
contacts.each do |contact|
  pp contact.data
end
```

list returns a list of Billomat::Models::Contact. To get at the date call the data property.

``` RUBY
contacts = Billomat::Models::Contact.paged_list(page = 2, per_page = 10)
pp contacts
```

paged_list returns a hash whith two properties, data wich contains the same data as list does and paging_data, a hash that has page, per_page and total as properties.

## Filter

You can filter by attribute, in this case the last_name attribute.

``` BASH
curl -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/contacts\?last_name\=Mustaman
```

The same can be achieve in ruby by:

``` RUBY
contacts = Billomat::Models::Contact.where({"last_name": "Mustaman"})
```

### Create

Lets create an client contact by sending the fallowing JSON to the API.

``` JSON
{
  "contact": {
    "client_id": 7233379,
    "first_name": "Mustafa",
    "last_name": "Mustaman",
    "street": "Musterstr. 1",
    "city": "Mutterstadt",
    "email": "mustafa.musterman@example.com"
  }
}
```

We do that by posting the data like this:

``` BASH
curl -X POST -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' -H 'Content-Type: application/json' -d '{"contact":{"client_id":7233379,"first_name":"Mustafa","last_name":"Mustama","street":"Musterstr. 1","city":"Mutterstadt","email":"mustafa.musterman@example.com"}}' https://<your-billomat-subdomain>.billomat.net/api/contacts
```

The return data is the resulting contact. The same can be achieved over in ruby like this:

``` RUBY
contact = Billomat::Models::Contact.new({
  "client_id": 7233379,
  "first_name": "Maria",
  "last_name": "Mustaman",
  "street": "Musterstr. 2",
  "city": "Mutterstadt",
  "email": "maria.musterman@example.com"
})
contact.save
```

The return data will be pushed to contact.data.

### Update

Lets update a contact.

``` JSON
{
  "contact": {
    "street": "Thomas-Mann-Straße 7"
  }
}
```

By putting the changed data to the API.

``` BASH
curl -X PUT -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' -H 'Content-Type: application/json' -d '{"client":{"street":"Via Ticino 1"}}' https://<your-billomat-subdomain>.billomat.net/api/contacts/101955
```

The same can be done in ruby by instantiating a contact with ID and saving.

``` RUBY
contact = Billomat::Models::Contact.new('id' => 101955, 'last_name' => 'Meyer')
contact.save
```

The save method is a switch that calls the update method if an id is set and create if not.

### Delete

You can delete a contact like this: 

``` BASH
curl -X DELETE -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/contacts/101950
```

Using the gem the same can be achieved by:

``` RUBY
contact = Billomat::Models::Contact.new('id' => 101955)
contact.delete
```

## User defined fields

Additional fields can be defined for Clients/Customers as well as a few other resources. Documentation for user defined fields in German (5).

### List

The per_page value defaults to 100, the page value to 1.

``` BASH
curl -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/client-property-values\?per_page\=2\&page\=1
```

The returned data is a nested object, client-property-values.client-property-value contains an array of all the returned client-property objects. If there is only one client-property-values.client-property-value is an object. There is code in utils.rs to handle this case.

``` JSON
{
  "client-property-values": {
    "client-property-value": [],
    "@page": "1",
    "@per_page": "2",
    "@total": "12"
  }
}
```

In ruby you have two ways to get at the list data. The first is to call the list function (page and per_page optional) and the second ist to call paged_list (again with page and per_page optional). Each give back slightly different data.

``` RUBY
client_properties = Billomat::Models::ClientProperty.list
client_properties.each do |property|
  pp property.data
end
```

list returns a list of Billomat::Models::ClientProperty. To get at the date call the data property.

``` RUBY
client_properties = Billomat::Models::ClientProperty.paged_list(page = 2, per_page = 10)
pp client_properties
```

paged_list returns a hash whith two properties, data wich contains the same data as list does and paging_data, a hash that has page, per_page and total as properties.

## Filter

You can filter by attribute, in this case the client_id attribute.

``` BASH
curl -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/client-property-values\?client_id\=7245269
```

The same can be achieve in ruby by:

``` RUBY
clients = Billomat::Models::ClientProperty.where({"client_number": "KD2"})
```

You can also filter on the client using client-property-values like described in the appropriate section above.

### Create

Lets create an client property by sending the fallowing JSON to the API.

``` JSON
{
  "client-property-value": {
    "client_id": "7233379",
    "client_property_id": "18291",
    "value": "ext-1237"
  }
}
```

We do that by posting the data like this:

``` BASH
curl -X POST -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Content-Type: application/json' -H 'Accept: application/json' -d '{"client-property-value":{"client_id":"7233379","client_property_id":"18291","value":"ext-1237"}}' https://<your-billomat-subdomain>.billomat.net/api/client-property-values
```

The return data is the resulting client-property-value. The same can be achieved over in ruby like this:

``` RUBY
client_property = Billomat::Models::ClientProperty.new({
  "client_id" => "7235858",
  "client_property_id" => "18291",
  "value" => "ext-1007"
})
client_property.save
```

The return data will be pushed to clientProperty.data.

### Update

Lets update a client property.

``` JSON
{
  "client-property-value": {
    "value":"ext-1234"
  }
}
```

By putting the changed data to the API.

``` BASH
curl -X PUT -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' -H 'Content-Type: application/json' -d '{"client-property-value":{"value":"ext-1234"}}' https://<your-billomat-subdomain>.billomat.net/api/client-property-values/9672334
```

The same can be done in ruby by instantiating a client property with ID and saving.

``` RUBY
client = Billomat::Models::ClientProperty.new('id' => 9672334, 'value' => 'ext-12345')
client.save
```

The save method is a switch that calls the update method if an id is set and create if not.

### Delete

You can delete a client property like this: 

``` BASH
curl -X DELETE -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/client-property-values/9672513
```

Using the gem the same can be achieved by:

``` RUBY
client = Billomat::Models::ClientProperty.new('id' => 9672334)
client.delete
```

## Metafield

Clients, like all resources in the API, have a field called customfield. It is a metadata field that can be set and searched for without having to use the property or tags API.

``` BASH
curl -X PUT -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' -H 'Content-Type: application/json' -d '{"invoice":{"customfield":"muster"}}' https://<your-billomat-subdomain>.billomat.net/api/clients/7245252/customfield
```

The same can be achieved in Ruby by:

``` RUBY
client = Billomat::Models::Client.new({
  'id' => 15949653,
  'customfield' => 'test data'
})
client.save
```

## Tags (Schlagwörter)

### List

### Create

### Update

### Delete

---

#### Links

\[1\] [English Client Documentation](https://www.billomat.com/en/api/clients/)  
\[2\] [German Client Documentation](https://www.billomat.com/api/kunden/)  
\[3\] [English Contact Documentation](https://www.billomat.com/en/api/clients/contacts/)  
\[4\] [German Contact Documentation](https://www.billomat.com/api/kunden/kontakte/)  
\[5\] [German Client Attribute Documentation](https://www.billomat.com/api/kunden/attribute/)  
