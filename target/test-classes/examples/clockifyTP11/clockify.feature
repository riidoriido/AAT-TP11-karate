@Regression @Test
Feature: Clockify w/ Karate

  Background:
    Given url baseUrl
    And header x-api-key = token

  @GetWorkspaces @Smoke
  Scenario: Get Workspaces
    And path 'workspaces'
    When method GET
    Then status 200
    * print response[6].id
    * def workspaceID = response[6].Id


  @AddClient
  Scenario: Add Client to Workspace
    * def responseWorkspace = call read('classpath:examples/clockifyTP11/clockify.feature@GetWorkspaces')
    * def clientName = read('classpath:examples/clockifyTP11/requests/newClient.json')
    And path 'workspaces', responseWorkspace.response[6].id, 'clients'
    And request clientName
    When method post
    Then status 201


  @GetClients @Smoke
  Scenario: Get Clients from Workspace
    * def workspace = call read('classpath:examples/clockifyTP11/clockify.feature@GetWorkspaces')
    And path 'workspaces', workspace.response[6].id, 'clients'
    When method get
    Then status 200
    * def clientID = response.id


  @AddNewProyect
  Scenario: Add new project to client
    * def workspace = call read('classpath:examples/clockifyTP11/clockify.feature@GetWorkspaces')
    * def responseClient = call read('classpath:examples/clockifyTP11/clockify.feature@GetClients')
    * def clientKarate = responseClient.response.id
    * def workspaceID = workspace.response[6].id
    * def projectBody = read('classpath:examples/clockifyTP11/requests/newProject.json')

    And path 'workspaces' , workspaceID , 'projects'
    And request projectBody
    And set projectBody.clientName = clientKarate
    When method post
    Then status 201