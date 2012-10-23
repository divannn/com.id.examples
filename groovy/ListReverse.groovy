class Node {
  String value;
  Node next;

  Node(String v, Node n) {
      value = v;
      next = n;
  }  
  String getValue() {
      value;
  }
  Node getNext() {
      next;
  }
  String toString() {
     getValue();
  }
  
}

Node n3 = new Node("3",null);
Node n2 = new Node("2",n3);
Node n1 = new Node("1",n2);

//dump1(n1);
dump2(n1);
println ("-" * 10)
dump2(reverse(n1));

//via recursion.
def dump1(Node head) {
    if (head != null) {
        println(head);
        dump1(head.next);
    }
}

//via loop.
def dump2(Node head) {
    while (head != null) {
        println (head);
        head = head.next;
    }
}

def Node reverse(Node head) {
    list = []
    Node next = head;
    while (next != null) {
        list << next;
        next = next.next;
    }
    list[0].next = null;
    for (int i = 1; i < list.size() ; i++) {
       list[i].next = list[i-1];
    }
    list[-1]
}



def Node reverse2(Node head) {
    Node curr = head;
    Node prev = null;
    Node next = curr.next;
    
    next.next = prev;
    next = next.next;
    while (next != null) {
        next = next.next;
    }    
    list[0].next = null;
    for (int i = 1; i < list.size() ; i++) {
       list[i].next = list[i-1];
    }
    list[-1]
}
