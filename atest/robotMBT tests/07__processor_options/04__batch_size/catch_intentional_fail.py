from robot.api import logger
from robot.api.deco import library
from robot.libraries.BuiltIn import BuiltIn


@library(scope='SUITE', listener='SELF')
class ForcedFailListener:
    ROBOT_LISTENER_PRIORITY = 2  # Set elevated priority, so other listeners (e.g. RIDE) also see the pass

    def end_test(self, tc, result):
        if tc.name == "Confirm exit criteria":
            if result.status == 'FAIL' and result.message == "Not all targets achieved":
                BuiltIn().set_suite_variable('${confirmed_pass}', True)
                result.status = 'PASS'
                logger.info("Expected failure confirmed. Result flipped to PASS.")
            else:
                result.status = 'FAIL'
                result.message = "Expected failure remained unconfirmed"
