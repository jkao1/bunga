public class MyBST {

    private Node root;

    public MyBST() {
        root = null;
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
            if ( e.compareTo( node.getEvent() ) <= 0 ) {
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
        if (root.getEvent().compareTo( e ) == 0)
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
        if ( e.compareTo( root.getEvent() ) < 0 ) {
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
        while ( (node != null) && !isFound)
            {
                Event nodeEvent = node.getEvent();
                if ( e.compareTo( nodeEvent ) < 0 ) {
                    node = node.getLeft();
                } else if ( e.compareTo( nodeEvent ) > 0 ) {
                    node = node.getRight();
                } else {
                    isFound = true;
                    break;
                }
                isFound = search( node, e );
            }
        return isFound;
    }


    public void printInOrder() {
        printInOrder( root );
    }

    private void printInOrder(Node node)
    {
        if ( node != null ) {
            printInOrder( node.getLeft() );
            System.out.print( node.getEvent() + " " );
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
