public class Location {

    private String streetAddress;
    private String city;
    private String state; // two letters
    private int zipcode;

    public Location(String streetAddress, String city, String state, int zipcode)
    {
        this.streetAddress = streetAddress;
        this.city = city;
        this.state = state;
        this.zipcode = zipcode;
    }


    public String toString()
    {
        return streetAddress + ", " + city + ", " + state + " " + zipcode;
    }
}
