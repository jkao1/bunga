public class MyHeap {

    private int O_CONST;

    private Event[] ary;
    private int size;

    public MyHeap() {
        ary = new Event[10];
        size = 1;
    }

    public MyHeap(boolean isMax) {
        this();
        if (isMax) {
            O_CONST = 1;
        } else {
            O_CONST = -1;
        }
    }
    
    public boolean isEmpty() {
        return size <= 1;
    }

    public void add(Event s)
    {
        if (size == ary.length) {
            resize();
        }
        ary[size] = s;
        pushUp();
        size++;
    }

    private void pushUp()
    {
        int tracker = size;
        while (tracker > 1 && ary[tracker].compareTo( ary[tracker / 2] ) * O_CONST > 0) {
            swap(tracker, tracker / 2);
            tracker = tracker / 2;
        }
    }

    private void resize()
    {
        Event[] biggerAry = new Event[ary.length * 2];
        for (int i = 0; i < ary.length; i++) {
            biggerAry[i] = ary[i];
        }
        ary = biggerAry;
    }

    public Event remove()
    {
        Event output = ary[1];
        ary[1] = ary[size - 1];
        pushDown();
        size--;
        return output;
    }
    
    public int size() {
        return size - 1;
    }

    private void pushDown()
    {
        int tracker = 1;
        while (2 * tracker + 1 < size) {
            boolean goLeft = ary[2 * tracker].compareTo(ary[2 * tracker + 1]) * O_CONST > 0;
            if (goLeft) {
                if (ary[tracker].compareTo( ary[2 * tracker] ) * O_CONST < 0) {
                    swap(tracker, 2 * tracker);
                    tracker = 2 * tracker;
                } else if (ary[tracker].compareTo( ary[2 * tracker + 1] ) * O_CONST < 0) {
                    swap(tracker, 2 * tracker + 1);
                    tracker = 2 * tracker + 1;
                } else {
                    break;
                }
            } else {
                if (ary[tracker].compareTo( ary[2 * tracker + 1] ) * O_CONST < 0) {
                    swap(tracker, 2 * tracker + 1);
                    tracker = 2 * tracker + 1;
                } else if (ary[tracker].compareTo( ary[2 * tracker] ) * O_CONST < 0) {
                    swap(tracker, 2 * tracker);
                    tracker = 2 * tracker;
                }  else {
                    break;
                }
            }
        }
    }

    public Event peek()
    {
        return ary[1];
    }

    private void swap(int a, int b)
    {
        Event temp = ary[a];
        ary[a] = ary[b];
        ary[b] = temp;
    }
    
    public MyHeap clone()
    {
        MyHeap output = new MyHeap();
        System.out.println(this);
        for (int i = 1; i < size; i++) {
           output.add( ary[i] );
        }
        return output;
    }

    public String toString()
    {
        String output = "[";
        for (int i = 1; i < size; i++) {
            output += ary[i] + ", ";
        }
        if (size > 1) {
            output = output.substring(0, output.length() - 2);
        }
        return output + "]";
    }

}