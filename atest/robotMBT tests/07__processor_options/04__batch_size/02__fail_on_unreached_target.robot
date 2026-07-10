*** Settings ***
Documentation     With the introduction of on-the-fly trace generation, a test run can be started
...               before it is known whether the requested coverage target can be reached. If the
...               test run finishes before the coverage target is achieved, a special scenario is
...               inserted that will fail. This ensures a failed test run, even if all tests up to
...               this point passed. This test suite checks that mechanism.
Suite Setup       Treat this test suite Model-based    batch_size=2    coverage_target=1
Suite Teardown    Should Be True    ${confirmed_pass}    # set by listener after catching intended failure
Library           robotmbt
Library           catch_intentional_fail.py


*** Variables ***
${confirmed_pass}    ${False}


*** Test Cases ***
Scenario 1
    First

Scenario 2
    Second

Impossible Scenario
    Block here


*** Keywords ***
First
    [Documentation]    *model info*
    ...                :IN: None
    ...                :OUT: new item
    No Operation

Second
    [Documentation]    *model info*
    ...                :IN: item
    ...                :OUT: None
    No Operation

Block here
    [Documentation]    *model info*
    ...                :IN: False
    ...                :OUT: None
    No Operation
