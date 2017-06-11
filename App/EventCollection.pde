class EventCollection {
  
  TreeSet<Event> treeSetEvents;
  PrintWriter out;
  
  EventCollection(String filename) {
    out = createWriter("hi"); 
    out.println("hi");
    treeSetEvents = new TreeSet<Event>();
    String[] lines = loadStrings(filename);
    for (String line : lines) {
      String[] ary = line.split(","); 
      String name;        
      int year, month, date;
      String description =  "";
      int duration = 60;
      int type = (int) (Math.random() * 4);
      name = ary[0];
      year = Integer.parseInt(ary[1]);
      month = Integer.parseInt(ary[2]) - 1;
      date = Integer.parseInt(ary[3]);
      if (ary.length > 4) {
        duration = Integer.parseInt(ary[4]);
      }
      if (ary.length > 5) {
        description = ary[5];
      }
      if (ary.length > 6) {
        type = Integer.parseInt(ary[6]);
      }
      treeSetEvents.add( new Event( name, year, month, date, duration, description, type));
    }    
  }
  
  Event[] getEventsInMonth(int y, int m) {
    Set<Event> temp = treeSetEvents.subSet( new Event( "", y, m, 1 ), new Event( "", y, m + 1, 1 ));
    Event[] output = temp.toArray( new Event[ temp.size() ]);
    return treeSetEvents.toArray(new Event[treeSetEvents.size()]);
  }
  
  Event[] getEventsInWeek(int y, int m, int d) {
    Set<Event> temp = treeSetEvents.subSet( new Event( "", y, m, d ), new Event( "", y, m, d + 8 ));
    Event[] output = temp.toArray( new Event[ temp.size() ]);
    return treeSetEvents.toArray(new Event[treeSetEvents.size()]);
  }
  
  Event[] getEventsInDay(int y, int m, int d) {
    Set<Event> temp = treeSetEvents.subSet( new Event( "", y, m, d ), new Event( "", y, m, d + 1 ));
    Event[] output = temp.toArray( new Event[ temp.size() ]);
    return treeSetEvents.toArray(new Event[treeSetEvents.size()]);
  }
  
  void add(Event e) {
    treeSetEvents.add(e);
    out.println(e.writeOutString());
  }
  
  void close() {
    out.flush();
    out.close();
  }
  
  String toString() {
    return treeSetEvents.toString();
  }
  
}