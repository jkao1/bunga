class DayCollection {
  
  ArrayList<Day> days;
  int size;
  
  DayCollection() {
    days = new ArrayList<Day>();
    size = 0;
  }
  
  void add(Day d) {
    days.add(d);
    size++;
  }
  
  Day get(int i) {
    if (i < 0 || i >= size) {
      throw new IndexOutOfBoundsException("" + i);
    }
    return days.get(i);
  }
  
  void clear() {
    days = new ArrayList<Day>();
    size = 0;
  }
  
  int size() {
    return days.size();
  }
}