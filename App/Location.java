public class Location {

    private String streetAddress;
    private String city;
    private String state; // two letters
    private String zipcode;

    public Location(String streetAddress, String city, String state, String zipcode)
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