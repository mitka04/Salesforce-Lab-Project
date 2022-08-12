/**
 * Created by mzulubiev on 15.07.2022.
 */


public class JSON2Apex {

    public List<Result> results;
    public Name name {get; set;}

    public class Result {
        public Name name;
    }

    public class Name{
        public String first;
        public String last;
    }
}
