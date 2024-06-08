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
    * print "Workspace ", response[6].name, " with ID ", response[6].id, " was selected"
    * def workspaceID = response[6].Id


  @AddClient
  Scenario: Add Client to Workspace
    * def responseWorkspace = call read('clockify.feature@GetWorkspaces')
    * def clientName = read('classpath:examples/clockifyTP11/requests/newClient.json')
    And path 'workspaces', responseWorkspace.response[6].id, 'clients'
    And request clientName
    When method post
    Then status 201


  @GetClients
  Scenario: Get Clients from Workspace
    * def workspace = call read('clockify.feature@GetWorkspaces')
    And path 'workspaces', workspace.response[6].id, 'clients'
    When method get
    Then status 200
    * def clientID = response.id


  @AddNewProyect
  Scenario: Add new project to client
    * def workspace = call read('clockify.feature@GetWorkspaces')
    * def responseClient = call read('clockify.feature@GetClients')
    * def projectBody = read('classpath:examples/clockifyTP11/requests/newProject.json')
    * set projectBody.clientId = responseClient.response[0].id
    And path 'workspaces' , workspace.response[6].id , 'projects'
    And request projectBody
    When method post
    Then status 201
    And match response.clientName == "clientKarate"
    * print "Proyect was assigned to " + response.clientName

    @GetTimeEntries @Smoke
    Scenario: Get Time Entries for User
      * def workspace = call read('clockify.feature@GetWorkspaces')
      * def userID = workspace.response[6].memberships[0].userId
      And path 'workspaces', workspace.response[6].id, 'user', userID, 'time-entries'
      And param start = '2024-05-31T11:00:00Z'
      And param end = '2024-06-03T17:00:00Z'
      When method get
      Then status 200
      * def calculateHours = read('classpath:examples/clockifyTP11/scripts/calculateHours.js')
      * def entry1hours =
        """
        karate.eval('calculateHours(response[0].timeInterval.start, response[0].timeInterval.end)')
        """
      * def entry2hours =
        """
        karate.eval('calculateHours(response[1].timeInterval.start, response[1].timeInterval.end)')
        """
      * def totalHours = entry1hours + entry2hours
      * print 'Total Hours:', totalHours

