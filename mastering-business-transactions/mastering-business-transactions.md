Perform 2021

Mastering Business Transactions

[Hands-on 1](#hands-on-1)

[Hands-on 2](#hands-on-2)

[Hands-on 3](#hands-on-3)

[Hands-on 4](#hands-on-4)

[Appendix](#appendix)

# Hands-on 1

## 1) User action naming
1. Navigate to "Applications"
1. Click on "My web application"
1. Top-right menu, click on the three dots button "..."
1. Click on "Edit"
1. Click on "Capturing" menu group
1. Click on "User actions"
1. Scroll down to "User action naming rules"
1. Click the middle tab "Naming rules for XHR actions"
1. Click "Add naming rule"
1. Paste the text below in the field "Naming pattern"
```{userInteraction} on "{elementIdentifier}"```
1. Scroll down to validate in "Preview your rule"
1. Click "Save"

## 2) Key user actions

1. Navigate to "Applications"
1. Click on "My web application"
1. Scroll down to find "Top 3 user actions" section
1. Click on "View full details" of this section
1. Scroll down to the list of actions
1. In the filter, type "sign in"
1. Find the action in the filtered table
1. Click on the name of the action
1. Top-right menu, click on the three dots button "..."
1. Click "Mark as key user action"
1. Click on "User actions" in the breadcrumbs menu
1. Scroll down to the list of actions
1. In the filter, type "book now"
1. Find the action in the filtered table
1. Click on the name of the action
1. Top-right menu, click on the three dots button "..."
1. Click "Mark as key user action"
1. Click on "User actions" in the breadcrumbs menu
1. Scroll down to the list of actions
1. Click on the tab "Key user actions (2)"
1. Find the two actions that were defined

## Conversion goal

1. Navigate to "Applications"
1. Click on "My web application"
1. Top-right menu, click on the three dots button "..."
1. Click on "Edit"
1. Click on "Session Replay and behaviour" menu group
1. Click on "Conversion goals"
1. Click on "Add goal"
1. Type "Travel bookings" on "Name" field
1. Change "Type of goal" to "User Action"
1. Change "Rule applies to" to "XHR actions"
1. Change "begins with" to "contains"
1. Type "book journey for" in the last field
1. Click on "Add goal"

## Create dashboard
1. Add one tile for the each key user action
1. Add one tile for the conversion goal

# Hands-on 2

## Funnel query

1. Navigate to "User sessions"
1. Click on "User session query"
1. Type the query below in the input field
```
SELECT FUNNEL(useraction.name='loading of page /easytravel/search' AS 'Search', useraction.name='click on "book now"' AS 'Book', useraction.name='click on "sign in"' AS 'Authenticate', useraction.name LIKE '*book journey for*' AS 'Pay') FROM usersession
```
1. Click on "Run query"
1. Click the pencil to edit the name
1. Type "Conversion funnel"
1. Click on "Pin to dashboard"
1. Make sure our dashboard is selected
1. Click on "Pin"
1. Click on "Open dashboard"
1. Position the tile just below the first row

## Key request

1. Click on the "book now" key user action tile
1. Top-right menu, click on the three dots button "..."
1. Click on "Analyze user sessions"
1. Type "Converted" in the filter field
1. Select "Yes"
1. Select any user from the list
1. Click on one of the user's sessions
1. Scroll down to find the conversion action
1. Click on the arrow in the far right of the line
1. Click on "Perform waterfall analysis"
1. Click on the "/bookings/" request
1. Click on "View PurePath"
1. Click on the PurePath name
1. Check in the PurePath that we have the method "storeBooking" in the trace
1. Make sure you select the one in the BookingService!
1. Click on the "storeBooking" link, in the Summary tab
1. Remove the instance filter
1. Top-right menu, click on the three dots button "..."
1. Click on "Mark as key request"
1. Click on "Pin to dashboard"
1. Make sure our dashboard is selected
1. Click on "Pin"
1. Click on "Open dashboard"
1. Position the tile to the right of the funnel


# Hands-on 3

1. Navigate to "Settings"
1. Click on "Server-side service monitoring" menu group
1. Click on "Request attributes"

## Define Revenue request attribute
1. Click on "Define a new request attribute"
1. Type "Revenue" on "Request attribute name"
1. Change "Data type" to "Double"
1. Click on "Add new data source"
1. Change "Request attribute source" to "Java method parameter(s)"
1. Click on "Select method sources"
1. Type "backend" and choose the "com.dynatrace.easytravel.business.backend.jar" process group
1. Click on the process that appears
1. Click on "Continue"
1. Type "BookingService"
1. Click on "Search"
1. Select the class that was found
1. Click on "Continue"
1. Make sure "Use the selected class" is selected
1. Click on "Continue"
1. Click on "Show 10 more"
1. Find the method "public java.lang.String storeBooking(...)"
1. Mark its checkbox
1. Click on "Finish"
1. Verify the method appears
1. Change "Capture" value from "Class name" to "4: java.lang.Double"
1. Click "Save" in the method source section
1. Click "Save" at the top of the screen

## Define Loyalty status request attribute
1. Click on "Define a new request attribute"
1. Type "Loyalty Status" on "Request attribute name"
1. Leave "Data type" as "Text"
1. Click on "Add new data source"
1. Change "Request attribute source" to "Java method parameter(s)"
1. Click on "Select method sources"
1. Type "backend" and choose the "com.dynatrace.easytravel.business.backend.jar" process group
1. Click on the process that appears
1. Click on "Continue"
1. Type "BookingService"
1. Click on "Search"
1. Select the class that was found
1. Click on "Continue"
1. Make sure "Use the selected class" is selected
1. Click on "Continue"
1. Click on "Show 10 more"
1. Find the method "private void checkLoyaltyStatus(...)"
1. Mark its checkbox
1. Click on "Finish"
1. Verify the method appears
1. Change "Capture" value from "Class name" to "2: java.lang.String"
1. Click "Save" in the method source section
1. Click "Save" at the top of the screen


## Summary of request attributes properties

```
Name: Loyalty Status
Data type: Text
Process “com.dynatrace.easytravel.business.backend.jar”
Class: com.dynatrace.easytravel.business.webservice.BookingService
Method: private void checkLoyaltyStatus
Argument: 2: java.lang.String (Text)
```

```
Name: Revenue
Data type: Double
Process “com.dynatrace.easytravel.business.backend.jar”
Class: com.dynatrace.easytravel.business.webservice.BookingService
Method: public java.lang.String storeBooking
Argument: 4: java.lang.Double (Double)
```

## Validate capturing

1. Navigate to Transactions & Services
1. Type "Request attribute" in the filter bar
1. Select Revenue
1. Click on "BookingService"
1. Click on "View requests"
1. Scroll down to the bottom of the page
1. Click the tab "Request attributes"
1. Expand the arrow at the right side of the row
1. Validate that both attributes are showing data

# Hands-on 4

## Preview with "multi-dimensional analysis"
1. Navigate to "Transactions and Services"
1. Click on "BookingService"
1. Click on "Create analysis view"
1. Select "Revenue" as Metric
1. Delete the default "Split by dimension" value
1. Type "loyalty" and click the auto-completed value "{RequestAttribute:Loyalty Status}"
1. Either click the checkmark at the end of the field or type "<tab>"
1. In the "Filter requests" field type "attribute" and click the auto-completed value "Request attribute"
1. Select "Loyalty Status"
1. Type "Platinum" (upper case 'P')
1. Type "<enter>"

## Create metric to track value

1. Click on "Create metric..."
1. Type "Revenue from Platinum customers" on the "Metric name"
1. Click on "Create metric"
1. Click on "Create custom chart"

## Add chart to dashboard

1. Wait a minute or so for the metric to be first calculated
1. Expand the metric row
1. Mark the checkbox for "Service" 
1. Mark the checkbox for "Dimensions"
1. Scroll down to see the dimensions
1. Edit the colors: None is 'black', Gold is 'gold', Silver is 'silver', Platinum is 'gray'
1. Click on "Pin to dashboard"
1. Make sure our dashboard is selected
1. Click on "Pin"
1. Click on "Open dashboard"
1. Position the tile below the funnel

## Custom events for alerting

1. Navigate to "Settings"
1. Click on "Anomaly detection" menu group
1. Click on "Custom events for alerting"
1. Click on "Create custom event for alerting"
1. Type "revenue" in the Metric field and select the metric
1. Expand "Dimensions"
1. Click on the "Filtered by" field and select "Platinum"
1. Click on "Add rule-based filter"
1. Click on "Value" field and select "BookingService"
1. Click on "Create rule-based filter"
1. Select "Auto-adaptive baseline"
1. Type "1" in the signal fluctuation value
1. Change from "above" to "below"
1. Type "2" in the first numeric field
1. Type "30" in the second numeric field
1. Type "Reduced bookings for Platinum users"
1. Click on "Create custom event for alerting" 

We will not wait for the alert to happen.

# Appendix

### Feature navigation reference

#### Feature: user action naming
* Access the Applications page and click on one of the applications
* Click on the three dots button at the top-right and click on Edit
* In the internal menu, click on "User actions"
* You may add placeholders for later use on rules
* You will choose which type of action you want to rename: load or XHR
* Click on "Add naming rule" and define the pattern
* Check the Preview to see if it’s what you intended

Validation
* Go to a user session
* Check the names of the actions

#### Feature: key user action
* Access the Applications page and click on one of the applications
* Look for the "Top 3 actions" section and click on "View full details"
* The page that opens up is called "User action analysis"
* Click on the name of the action
* Click on "Mark as key user action" at the top-right

Validation
* Go to the "User action analysis" page
* Check the "Key user actions" section

#### Feature: conversion goal
* Access the Applications page and click on one of the applications
* Click on the three dots button at the top-right and click on Edit
* In the internal menu, click on "Conversion goals"
* Click on "Add goal"
* Use the form to create the goal

Validation
* Make sure to set a name to preview the percentage
* Go to the User session page
* Set the timeframe for more than 30 minutes (conversion goals are calculated for completed sessions only)
* In the filter bar, use the value "Conversional goal" to see if your goal is being reached

#### Feature: user session queries (also called USQL)
* Access the User sessions page
* Click on the "User session query" button
* Type the query you wish, the auto-completion will help you

Validation
* Run the query and check the results
* Optionally save the results to a dashboard

### Feature: key request
* Access the "Transactions & services" page and click on one of the services
* In the "Understand dependencies" section, click on "View web requests"
* Click on the name of one of the requests
* At the top-right of the page, click on the three dots button
* Click on "Mark as key request"

Validation
* In the Service details page, the section Key Requests will show your new key request

### Feature: request naming
* Access the "Transactions & services" page and click on one of the services
* Click on the three dots button and click on Edit
* In the internal menu, click on "Request naming rules"
* Find the heading "Request naming rules" and click "Add rule"
* Specify the new naming pattern and then the conditions 

Validation
* Access the "Transactions & services" page and click on one of the services
* In the "Understand dependencies" section, click on "View web requests"
* Check the names of the requests

### Feature: request attributes
* Access the Settings page
* Click on the group "Server-side service monitoring" and then click on "Request attributes"
* Click on "Define a new request attribute" to define a new one
* You will first define the properties of the value
* You will then define the source (where you want to capture it)
* Optionally define post-processing rules to further customize it

Validation
* In the "Transactions & services" page, use the filter bar to filter by Request atribute
* Open one of the service’s details page and scroll to the bottom
* You will see a Request Attributes tab in the Top Contributors section

### Feature: multi-dimensional analysis view
* Acess the service details page of a Service
* In the "Multidimensional analysis views" section, click on "Create chart"
* Choose metrics, filters and dimensions

Validation
* The page will load the chart immediately
* Optionally pin the chart to a services page
* Optionally create a Calculated Service Metric 

### Feature: calculated service metrics
* Access the Settings page
* Click on the group "Server-side service monitoring" and then click on "Calculated Service Metrics"
* Click on "Create new metric" to define a new one
* You will first define the properties of the source
* You will then define the filters to restrict calculation
* You will then define dimension properties

Validation
* Create a Custom Chart and search for the name of the new metric


### Feature: custom events for alerting
* Access the Settings page
* Click on the group "Anomaly detection" and then click on "Custom events for alerting"
* Click on "Create custom event for alerting"
* You will define the Severity
* You will then define the metric, choosing the aggregation and dimensions
* Play with the thresholds and the preview
* You will finish it by defining the description

Validation
* Use the preview
* Wait for the event to appear


## H02 extra

Extra exercise:
1. Define a request naming for image requests: URL path contains “dt-map”
1. Is it a business problem if the image of a big marketing campaign is not loading?

