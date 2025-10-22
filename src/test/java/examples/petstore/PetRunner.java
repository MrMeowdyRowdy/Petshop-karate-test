package examples.petstore;

import com.intuit.karate.junit5.Karate;

class PetRunner {

    @Karate.Test
    Karate runAll() {
        return Karate.run().relativeTo(getClass());
    }
}
