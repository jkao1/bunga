import java.util.Scanner;
import java.util.ArrayList;
import java.io.File;
import java.io.IOException;

public class MyBST {

    private Node root;
    
    public static void main(String[] args) {
        MyBST b = new MyBST( args[0] );
        b.printInOrder();
        System.out.println( b.findEvents( 2017, 6, 23 ));
    }

    public MyBST() {
        root = null;
    }
    
    public MyBST(String filename) {
        this();
        Scanner in = null;
        try {
            in = new Scanner( new File( filename ));
            while ( in.hasNextLine() ) {
                String lin = in.nextLine();
                System.out.println(lin);
                Scanner line = new Scanner( lin );
            
                line.useDelimiter(",");            
                String name;
                int year, month, date;
                String description =  "";
                int duration = 60;
                int type = (int) (Math.random() * 4);
                System.out.println(3);
                name = line.next();
                System.out.println(3);
                year = line.nextInt();
                month = line.nextInt();
                date = line.nextInt();
                if ( line.hasNext() ) {
                    duration = line.nextInt();
                }
                if ( line.hasNext() ) {
                    description = line.next();
                }
                if ( line.hasNext() ) {
                    type = line.nextInt();
                }
                insert( new Event( name, year, month, date, duration, description, type ));
            }
        } catch (IOException e) {
            System.out.println("FILE NOT FOUND: " + filename);
        }
    }
            

    public boolean isEmpty()
    {
        return root == null;
    }

    public void insert(Event e)
    {
        root = insert(root, e);
    }

    private Node insert(Node node, Event e)
    {
        if ( node == null ) {
            node = new Node( e );
        } else {
            if ( e.compareDateTo( node.getEvent() ) <= 0 ) {
                node.left = insert( node.left, e );
            } else {
                node.right = insert( node.right, e );
            }
        }
        return node;
    }

    public void delete( Event e )
    {
        if ( isEmpty() ) {
            System.out.println("Tree is empty; cannot delete event " + e + '.');
        } else if ( !inTree( e ) )
            System.out.println("Event " + e + " not foud in tree.");
        else
            {
                root = delete( root, e );
                System.out.println("Event " + e + " was deleted.");
            }
    }

    private Node delete(Node root, Event e)
    {
        Node p, p2, n;
        if (root.getEvent().compareDateTo( e ) == 0)
            {
                Node left, right;
                left = root.getLeft();
                right = root.getRight();
                if ( left == null && right == null ) {
                    return null;
                } else if ( left == null ) {
                    p = right;
                    return p;
                } else if ( right == null ) {
                    p = left;
                    return p;
                } else {
                    p2 = right;
                    p = right;
                    while ( p.getLeft() != null ) {
                        p = p.getLeft();
                    }
                    p.setLeft(left);
                    return p2;
                }
            }
        if ( e.compareDateTo( root.getEvent() ) < 0 ) {
            n = delete( root.getLeft(), e );
            root.setLeft( n );
        } else {
            n = delete( root.getRight(), e );
            root.setRight( n );
        }
        return root;
    }

    public boolean inTree(Event e)
    {
        return search(root, e);
    }

    private boolean search(Node node, Event e)
    {
        boolean isFound = false;
        while ( (node != null) && !isFound) {
            Event nodeEvent = node.getEvent();
            if ( e.compareDateTo( nodeEvent ) < 0 ) {
                node = node.getLeft();
            } else if ( e.compareDateTo( nodeEvent ) > 0 ) {
                node = node.getRight();
            } else {
                isFound = true;
                break;
            }
            isFound = search( node, e );
        }
        return isFound;
    }

    public ArrayList<Event> findEvents(int year, int month, int date)
    {
        ArrayList<Event> output = new ArrayList<Event>();
        return findEvents( root, new Event("",year,month,date), output );
    }

    public ArrayList<Event> findEvents(Node node, Event e, ArrayList<Event> output)
    {
        if (node == null) { // reached the end
            return output;
        }
        Event nodeEvent = node.getEvent();
        if ( e.compareDateTo( nodeEvent ) < 0 ) {
            node = node.getLeft();
        } else if ( e.compareDateTo( nodeEvent ) > 0 ) {
            node = node.getRight();
        } else {
            output.add( node.getEvent() );
            node = node.getLeft();
        }
        findEvents( node, e, output );
        return output;
    }


    public void printInOrder() {
        printInOrder( root );
    }

    private void printInOrder(Node node)
    {
        if ( node != null ) {
            printInOrder( node.getLeft() );
            System.out.print( node.getEvent() + ", " );
            printInOrder( node.getRight() );
        }
    }

    private class Node {

        Node left, right;
        Event event;

        public Node(Event e) {
            event = e;
        }

        public void setLeft(Node n)
        {
            left = n;
        }

        public void setRight(Node n)
        {
            right = n;
        }

        public Node getLeft()
        {
            return left;
        }

        public Node getRight()
        {
            return right;
        }

        public void setEvent(Event e)
        {
            event = e;
        }

        public Event getEvent()
        {
            return event;
        }
    }
}
