# Invoice

Documentation exists in English (1) and German (2). Both cover the basics of Invoicing, comments and payment. The German version also covers invoice positions and tags (Schlagwörter). If you can try to follow the German documentation since it is more complete than the English version. The documentation shows the method (get, put, post, delete) and the path and query parameters beyond the base URL as well as some of the parameters the URL takes. All examples are in XML and often are escaped. To read the code you will need to unescape the examples.

All examples here will be shown once in CURL and JSON and once using the Billomat Gem. If you replace <your-billomat-api-key> and <your-billomat-subdomain> with the correct values you should be able to use the following curl commands.

## List

The per_page value defaults to 100, the page value to 1.

``` BASH
curl -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/invoices\?per_page\=2\&page\=1
```

The returned data is a nested object, invoices.invoice contains an array of all the returned invoice objects. If there is only one invoices.invoice is an object. There is code in utils.rs to handle this case.

``` JSON
{
  "invoices": {
    "invoice": [],
    "@page": "1",
    "@per_page": "2",
    "@total": "12"
  }
}
```

In ruby you have two ways to get at the list data. The first is to call the list function (page and per_page optional) and the second is to call paged_list (again with page and per_page optional). Each give back slightly different data.

``` RUBY
invoices = Billomat::Models::Invoice.list
invoices.each do |invoice|
  pp invoice.data
end
```

list returns a list of Billomat::Models::Invoice. To get at the date call the data property.

``` RUBY
invoices = Billomat::Models::Invoice.paged_list(page = 2, per_page = 10)
pp invoices
```

paged_list returns a hash with two properties, data which contains the same data as list does and paging_data, a hash that has page, per_page and total as properties.

## Filter

You can filter by attribute, in this case the customfield attribute.

``` BASH
curl -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/invoices/\?customfield\=649062cae817b347c8780fb5
```

In ruby you can filter by calling the where method on the resource.

``` RUBY
invoices = Billomat::Models::Invoice.where({"customfield": "test data"})
```

## Create

There are multiple ways of working with invoices items. The easiest way to deal with them is to just nest them during invoice creation. If you need to manipulate the invoice items afterwards there is a separate invoice items api that can be used for that (3).  
Lets create an invoice by sending the following JSON to the API.

``` JSON
{
  "invoice": {
    "client_id": 7233379,
    "address":"Musterfirma\nMax Muster\nMusterstraße 1\nMusterhausen",
    "date": "2023-07-03",
    "supply_date": "2023-07-03",
    "supply_date_type": "SUPPLY_DATE",
    "discount_days": 14,
    "payment_types": "BANK_TRANSFER",
    "intro": "Short intro text!",
    "note": "Note: Due date is [Invoice.due_date].",
    "invoice-items": {
      "invoice-item": [
        {
          "article_id": 1439750,
          "quantity": "1"
        },
        {
          "article_id": 1439751,
          "quantity": "1"
        }
      ]
    }
  }
}
```

We do that by posting the data like this:

``` BASH
curl -X POST -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' -H 'Content-Type: application/json' -d '{"invoice":{"client_id":7233379,"address":"Musterfirma\nMax Muster\nMusterstraße 1\nMusterhausen","date":"2023-07-03","supply_date":"2023-07-03","supply_date_type":"SUPPLY_DATE","discount_days":14,"payment_types":"BANK_TRANSFER","intro":"Short intro text!","note":"Note: Due date is [Invoice.due_date].","invoice-items":{"invoice-item":[{"article_id":1439750,"quantity":"1"},{"article_id":1439751,"quantity":"1"}]}}}' https://<your-billomat-subdomain>.billomat.net/api/invoices
```

The return data is the resulting invoice in draft status. The same can be achieved over in ruby like this:

``` RUBY
client_id = 7235883
client = Billomat::Models::Client.find(client_id)
now = DateTime.now.to_date.as_json
invoice_data = {
  'client_id' => client_id,
  'address' => client.data.address,
  'date' => now,
  'supply_date' => now,
  'supply_date_type' => 'SUPPLY_DATE',
  'discount_days' => 14,
  'payment_types' => 'BANK_TRANSFER',
  'intro' => 'Short intro text!',
  'note' => 'Note: Due date is [Invoice.due_date].',
  'invoice-items' => {
    'invoice-item': [{
      'article_id': 1439750,
      'quantity': 1
    }, {
      'article_id': 1439751,
      'quantity': 1
    }]
  }
}
invoice = Billomat::Models::Invoice.new(invoice_data)
invoice.save
```

The return data will be pushed to invoice.data.

## Update

Lets update an invoice.

``` JSON
{
  "invoice": {
    "intro": "Updated intro!",
    "note": "Updated note!",
    "date": "2023-07-05",
    "supply_date": "2023-07-05"
  }
}
```

By putting the changed data to the API.

``` BASH
curl -X PUT -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' -H 'Content-Type: application/json' -d '{"invoice":{"intro":"Updated intro!","note":"Updated note!","date":"2023-07-05","supply_date":"2023-07-05"}}' https://<your-billomat-subdomain>.billomat.net/api/invoices/15949653
```

The same can be done in ruby by instantiating an invoice with ID and saving.

``` RUBY
invoice_data = {
  'id' => 15949653,
  'date' => '2023-07-07',
  'supply_date' => '2023-07-07',
  'intro' => 'Second updated intro!',
  'note' => 'Second updated note!'
}
invoice = Billomat::Models::Invoice.new(invoice_data)
invoice.save
```

The save method is a switch that calls the update method if an id is set and create if not.

## Delete

You can delete an invoice like this: 

``` BASH
curl -X DELETE -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/invoices/15949653
```

Using the gem the same can be achieved by:

``` RUBY
invoice = Billomat::Models::Invoice.new('id' => 15949653)
invoice.delete
```

## Invoice Items

### List

The easiest way to work on invoice items after the invoice has been created is to use the invoice items api. Lets list the items we have attached to an invoice.

``` BASH
curl -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/invoice-items\?invoice_id\=15896334
```

The return data is similar to that of an invoice.

``` JSON
{
  "invoice-items": {
    "invoice-item": [
    ],
    "@page": "1",
    "@per_page": "100",
    "@total": "3"
  }
}
```

In Ruby that call looks like this:

``` RUBY
invoice_items = Billomat::Models::InvoiceItem.where('invoice_id' => 15896334)
```

And the call returns an array of Billomat::Models::InvoiceItem instances.

### Create

Lets add this item to an invoice.

``` JSON
{
  "invoice-item": {
    "article_id": 1439751,
    "invoice_id": 15949653,
    "quantity": 1
  }
}
```

By posting it like this:

``` BASH
curl -X POST -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Content-Type: application/json' -H 'Accept: application/json' -d '{"invoice-item":{"article_id":1439751,"invoice_id":15949653,"quantity":1}}' https://<your-billomat-subdomain>.billomat.net/api/invoice-items
```

The return data is the created object. You can achieve the same in Ruby by doing this:

``` RUBY
invoice_item = Billomat::Models::InvoiceItem.new({
  'article_id': 1439750,
  'invoice_id': 15949653,
  'quantity': 1
})
invoice_item.save
```

The return data here is in the data attribute.

### Update

To update an invoice item you can just update the relevant fields. Here we update the quantity of an item and the item will be updated accordingly, calculating new total prices and so on

``` BASH
curl -X PUT -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' -H 'Content-Type: application/json' -d '{"invoice-item":{"quantity":2}}' https://<your-billomat-subdomain>.billomat.net/api/invoice-items/41129418
```

In Ruby the same thing can be achieved like this:

``` RUBY
invoice_item = Billomat::Models::InvoiceItem.new('id' => 41155556, 'quantity' => 5)
invoice_item.save
```

### Delete

Invoice items have their own ID and can be deleted like this:

``` BASH
curl -X DELETE -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/invoice-items/40962566
```

Using the gem the same can be achieved by:

``` RUBY
invoice_item = Billomat::Models::InvoiceItem.new('id' => 40962565)
invoice_item.delete
```

## Finalize

To finalize an invoice call the api endpoint like this:

``` BASH
curl -X PUT -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' -H 'Content-Type: application/json' -d '{"complete":{}}' https://<your-billomat-subdomain>.billomat.net/api/invoices/<infoice-id>/complete
```

The same can be done in ruby like this:

``` RUBY
invoice_id = 15951649
invoice = Billomat::Actions::Complete.new(invoice_id)
invoice.call
```

If you have a Billomat::Models::Invoice you can also call the complete! method to achieve the same.

## Cancel

To cancel (stornieren) an invoice call the api endpoint like this:

``` BASH
curl -X PUT -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' -H 'Content-Type: application/json' https://<your-billomat-subdomain>.billomat.net/api/invoices/15951649/cancel
```

Using the gem the same can be achieved by:

``` RUBY
invoice_id = 15949784
invoice = Billomat::Actions::Cancel.new(invoice_id)
invoice.call
```

If you have a Billomat::Models::Invoice instance you can call the cancel! method as an alternative.

## Download PDF

The pdf can be downloaded like this:

``` BASH
curl -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/pdf' https://<your-billomat-subdomain>.billomat.net/api/invoices/15951649/pdf --output invoice-15951649.pdf
```

The same can be done in ruby like this:

``` RUBY
invoice_id = 15951649
invoice = Billomat::Actions::Pdf.new(invoice_id)
pdf = invoice.call
file = File.open("#{$INVOICE_DOWNLOADS}/invoice-#{invoice_id}.pdf", 'wb')
file.write Base64.decode64(pdf['base64file'])
```

If you have a Billomat::Models::Invoice instance you can also call the to_pdf method to indirectly call the code to fetch the pdf. 

## Metafield

Invoices, like all resources in the API, have a field called customfield. It is a metadata field that can be set and filtered for without having to use the property or tags API.

``` BASH
curl -X PUT -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' -H 'Content-Type: application/json' -d '{"invoice":{"customfield":"muster"}}' https://<your-billomat-subdomain>.billomat.net/api/invoices/15829804/customfield
```

The same can be achieved in Ruby by:

``` RUBY
invoice = Billomat::Models::Invoice.new({
  'id' => 15949653,
  'customfield' => 'test data'
})
invoice.save
```

---

#### Links

\[1\] [English Invoice Documentation](https://www.billomat.com/en/api/invoices/)  
\[2\] [German Invoice Documentation](https://www.billomat.com/api/rechnungen/)  
\[3\] [German Invoice Items Documentation](https://www.billomat.com/api/rechnungen/positionen/)  
