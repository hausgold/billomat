# Article/Item/Position

Documentation exists in English (1) and German (2). Both cover articles as well as user defined properties. The German version also covers tags (Schlagwörter). If you can try to follow the German documentation since it is more complete than the English version. The documentation shows the method (get, put, post, delete) and the path and query parameters beyond the base URL as well as some of the parameters the URL takes. All examples are in XML and often are escaped. To read the code you will need to unescape the examples.

All examples here will be shown once in CURL and JSON and once using the Billomat Gem. If you replace <your-billomat-api-key> and <your-billomat-subdomain> with the correct values you should be able to use the following curl commands.

## List

The per_page value defaults to 100, the page value to 1.

``` BASH
curl -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/articles\?per_page\=2\&page\=1
```

The returned data is a nested object, articles.article  contains an array of all the returned article objects. If there is only one articles.article is an object. There is code in utils.rs to handle this case.

``` JSON
{
  "articles": {
    "article": [],
    "@page": "1",
    "@per_page": "2",
    "@total": "12"
  }
}
```

In ruby you have two ways to get at the list data. The first is to call the list function (page and per_page optional) and the second is to call paged_list (again with page and per_page optional). Each give back slightly different data.

``` RUBY
articles = Billomat::Models::Article.list
articles.each do |article|
  pp article.data
end
```

list returns a list of Billomat::Models::Article. To get at the date call the data property.

``` RUBY
articles = Billomat::Models::Article.paged_list(page = 2, per_page = 10)
pp articles
```

paged_list returns a hash with two properties, data which contains the same data as list does and paging_data, a hash that has page, per_page and total as properties.

## Filter

You can filter by attribute, in this case the type attribute.

``` BASH
curl -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/articles\?title\=shipping
```

Or you can filter by a user defined field by using "property\#\{article_property_id\}" as attribute.

``` BASH
curl -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/articles\?property5601\=service
```

In ruby you can filter by calling the where method on the resource.

``` RUBY
articles = Billomat::Models::Article.where({"title": "shipping"})
```

## Create

Lets create an article by sending the following JSON to the API.

``` JSON
{
  "article": {
    "type": "SERVICE",
    "title": "Update base data",
    "description": "Recollect data and update data in system.",
    "sales_price": "250"
  }
}
```

We do that by posting the data like this:

``` BASH
curl -X POST -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' -H 'Content-Type: application/json' -d '{"article":{"type":"SERVICE","title":"Update base data","description":"Recollect data and update data in system.","sales_price":"250"}}' https://<your-billomat-subdomain>.billomat.net/api/articles
```

The return data is the resulting article. The same can be achieved over in ruby like this:

``` RUBY
article = Billomat::Models::Article.new({
  "type" => "PRODUCT",
  "title" => "recard",
  "description" => "replacement card",
  "sales_price" => "10.95"
})
article.save
```

The return data will be pushed to article.data.

## Update

Lets update an article.

``` JSON
{
  "article": {
    "sales_price": "9.99"
  }
}
```

By putting the changed data to the API.

``` BASH
curl -X PUT -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' -H 'Content-Type: application/json' -d '{"article":{"sales_price":"9.99"}}' https://<your-billomat-subdomain>.billomat.net/api/articles/1444307
```

The same can be done in ruby by instantiating an article with ID and saving.

``` RUBY
article = Billomat::Models::Article.new('id' => 1444307, 'sales_price' => '10')
article.save
```

The save method is a switch that calls the update method if an id is set and create if not.

## Delete

You can delete an article like this: 

``` BASH
curl -X DELETE -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/articles/1444307
```

Using the gem the same can be achieved by:

``` RUBY
article = Billomat::Models::Article.new('id' => 1444301)
article.delete
```

## Tax Rates

Documentation for tax rates exists in English (1) and German (2). For Germany tax rates are predefined and you probably won't have to set up your own tax rates.

### List

The per_page value defaults to 100, the page value to 1.

``` BASH
curl -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/taxes\?per_page\=10\&page\=1
```

The returned data is a nested object, taxes.tax contains an array of all the returned tax rates (0%, 7% and 19%).

``` JSON
{
  "taxes": {
    "tax": [],
    "@page": "1",
    "@per_page": "2",
    "@total": "12"
  }
}
```

There is no way to do this in Ruby because you are unlikely to ever need to do this.

## User defined fields

Additional fields can be defined for articles as well as a few other resources. Documentation exists for user defined fields in English (5) and German (6).

### List

The per_page value defaults to 100, the page value to 1.

``` BASH
curl -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/article-property-values\?per_page\=5\&page\=1
```

The returned data is a nested object, article-property-values.article-property-value contains an array of all the returned article-property-values objects. If there is only one article-property-values.article-property-value is an object. There is code in utils.rs to handle this case.

``` JSON
{
  "article-property-values": {
    "article-property-value": [],
    "@page": "1",
    "@per_page": "2",
    "@total": "12"
  }
}
```

In ruby you have two ways to get at the list data. The first is to call the list function (page and per_page optional) and the second ist to call paged_list (again with page and per_page optional). Each give back slightly different data.

``` RUBY
article_property_values = Billomat::Models::ArticlePropertyValue.list
article_property_values.each do |property|
  pp property.data
end
```

list returns a list of Billomat::Models::ArticleProperty. To get at the date call the data property.

``` RUBY
article_property_values = Billomat::Models::ArticlePropertyValue.paged_list(page = 2, per_page = 10)
pp article_property_values
```

paged_list returns a hash with two properties, data which contains the same data as list does and paging_data, a hash that has page, per_page and total as properties.

### Filter

You can filter by attribute, in this case the article_id attribute.

``` BASH
curl -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/article-property-values\?article_id\=1434499
```

The same can be achieve in ruby by:

``` RUBY
article_property_values = Billomat::Models::ArticlePropertyValue.where({"article_id": "1434499"})
```

You can also filter on the article using article-property-values like described in the appropriate section above.

### Create

Lets create an article property by sending the following JSON to the API.

``` JSON
{
  "article-property-value": {
    "article_id": "1444406",
    "article_property_id": "5601",
    "value": "just some value"
  }
}
```

We do that by posting the data like this:

``` BASH
curl -X POST -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Content-Type: application/json' -H 'Accept: application/json' -d '{"article-property-value":{"article_id":"1444406","article_property_id":"5601","value":"just some value"}}' https://<your-billomat-subdomain>.billomat.net/api/article-property-values
```

The return data is the resulting article-property-value. The same can be achieved over in ruby like this:

``` RUBY
article_property_value = Billomat::Models::ArticlePropertyValue.new({
  "article_id": "1444406",
  "article_property_id": "5601",
  "value": "just some other value"
})
article_property_value.save
```

The return data will be pushed to article_property_value.data.


### Update

Lets update an article property value.

``` JSON
{
  "article-property-value": {
    "value":"one more time"
  }
}
```

By putting the changed data to the API.

``` BASH
curl -X PUT -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' -H 'Content-Type: application/json' -d '{"article-property-value":{"value":"one more time"}}' https://<your-billomat-subdomain>.billomat.net/api/article-property-values/4183225
```

The same can be done in ruby by instantiating an article property value with ID and saving.

``` RUBY
article_property_value = Billomat::Models::ArticlePropertyValue.new('id' => 4183225, 'value' => 'and done')
article_property_value.save
```

The save method is a switch that calls the update method if an id is set and create if not.

### Delete

You can delete an article property value like this: 

``` BASH
curl -X DELETE -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/article-property-values/9672513
```

Using the gem the same can be achieved by:

``` RUBY
article_property_value = Billomat::Models::ArticlePropertyValue.new('id' => 4169172)
article_property_value.delete
```

## Metafield

Articles, like all resources in the API, have a field called customfield. It is a metadata field that can be set and filtered for without having to use the property or tags API.

``` BASH
curl -X PUT -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' -H 'Content-Type: application/json' -d '{"article":{"customfield":"first-product"}}' https://<your-billomat-subdomain>.billomat.net/api/articles/1434499/customfield
```

The same can be achieved in Ruby by:

``` RUBY
article = Billomat::Models::Article.new({
  'id' => 1434499,
  'customfield' => 'first-product'
})
article.save
```

## Tags (Schlagwörter)

Documentation for article tags exists in German (5).

### List

The per_page value defaults to 100, the page value to 1.

``` BASH
curl -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/article-tags\?per_page\=5\&page\=1
```

The returned data is a nested object, article-tags.article-tag contains an array of all the returned article-tag objects. If there is only one article-tags.article-tag is an object. There is code in utils.rs to handle this case.

``` JSON
{
  "article-tags": {
    "article-tag": [],
    "@page": "1",
    "@per_page": "2",
    "@total": "12"
  }
}
```

In ruby you have two ways to get at the list data. The first is to call the list function (page and per_page optional) and the second is to call paged_list (again with page and per_page optional). Each give back slightly different data.

``` RUBY
article_tags = Billomat::Models::ArticleTag.list
article_tags.each do |tag|
  pp tag.data
end
```

list returns a list of Billomat::Models::ArticleTag. To get at the date call the data property.

``` RUBY
article_tags = Billomat::Models::ArticleTag.paged_list(page = 2, per_page = 10)
pp article_tags
```

paged_list returns a hash with two properties, data which contains the same data as list does and paging_data, a hash that has page, per_page and total as properties.

If you want to list the article tags of an article you can do so by calling:

``` BASH
curl -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/article-tags\?article_id\=1434499
```

The same can be achieved over in ruby like this:

``` RUBY
article_tag = Billomat::Models::ArticleTag.where('article_id' => 1434499)
pp article_tag
```

### Create

Lets add an article tag by sending the following JSON to the API.

``` JSON
{
  "article-tag": {
    "article_id": "1434499",
    "name": "imported"
  }
}
```

We do that by posting the data like this:

``` BASH
curl -X POST -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Content-Type: application/json' -H 'Accept: application/json' -d '{"article-tag":{"article_id":"1434499","name":"imported"}}' https://<your-billomat-subdomain>.billomat.net/api/article-tags
```

The return data is the resulting article-tag. The same can be achieved over in ruby like this:

``` RUBY
article_tag = Billomat::Models::ArticleTag.new({
  "article_id" => "7299528",
  "name" => "api-posted"
})
article_tag.save
```

The return data will be pushed to article_tag.data.

### Delete

You can delete an article tag like this: 

``` BASH
curl -X DELETE -H 'X-BillomatApiKey: <your-billomat-api-key>' -H 'Accept: application/json' https://<your-billomat-subdomain>.billomat.net/api/article-tags/126480
```

Using the gem the same can be achieved by:

``` RUBY
article_tag = Billomat::Models::ArticleTag.new('id' => 689750)
article_tag.delete
```

---

#### Links

\[1\] [English Article Documentation](https://www.billomat.com/en/api/articles/)  
\[2\] [German Article Documentation](https://www.billomat.com/api/artikel/)  
\[3\] [English Taxes Documentation](https://www.billomat.com/en/api/settings/taxes/)  
\[4\] [German Taxes Documentation](billomat.com/api/einstellungen/steuersaetze/)  
\[5\] [German Article Tag Documentation](https://www.billomat.com/api/artikel/schlagworte/)  
