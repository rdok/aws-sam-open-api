# AWS SAM OpenAPI

Spikes to an effective development flow to automating, & developing API Gateway with OpenAPI.

### How-To
> How to get the latest deployed OpenAPI?   
 
Use a command to export it from the API Gateway. `make export-openapi` Any developer, frontend or backend, should be able to run this.

> How to get OpenAPI which hasn't been implemented/deployed yet?
 
The developer responsible for creating the new OpenAPI should use an API Gateway mock response, using the relevant models.
And either deploy this to the testing stack. 
Or deploy it to a temporary cloudformation stack.
And finally, the developers requiring this work, should use the `make export-openapI` to get this mocked OpenAPI. [More details](https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-mock-integration.html)

