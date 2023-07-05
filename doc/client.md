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
curl -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/clients\?client_number\=KD2 | jq .
```

Or you can filter by a user defined field by using "property\#\{client_property_id\}" as attribute.

``` BASH
curl -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/clients\?property18280\=649062cae817b347c8780fb5 | jq .
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
client = Billomat::Models::Client.new('street' => 'Via Ticino 2')
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

### List

### Create

### Update

### Delete

## User defined fields

### List

### Create

### Update

### Delete

## Metafield

## Tags (Schlagwörter)

### List

### Create

### Update

### Delete

---

#### Links

\[1\] [English Client Documentation](https://www.billomat.com/en/api/clients/)  
\[2\] [German Client Documentation](https://www.billomat.com/api/kunden/)  
\[\] []()
