package examples.clockifyTP11;

import com.intuit.karate.junit5.Karate;

public class ClockifyRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("examples/clockifyTP11/clockify").relativeTo(getClass());
    }
}
