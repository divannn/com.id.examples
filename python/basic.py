#Usage loop 'for' with 'else'.
def useFor():
    for i in []:
        print i
    else:
        print "jopa"

#useFor()


#Usage loop 'while' with 'else'.
def useWhile():
    i = 0
    while i == 1:
        print i
        i += 1;
    else:
        print "jopa"

#useWhile()


#New conditional statement.
def newCond():
    return 1 if 2 > 1 else 0

#print newCond();

#Usage of exceptions.
def excepionUsage():
    i = 1
    try:
        b = i / 0
    except (Exception, IOError, NameError), e:
        print "Cought exception:", e
    else:
        pass

#excepionUsage()

#Raise an exception.
def raiseException():
    arg1 = "str"
    arg2 = 5
    try:
        raise Exception(arg1, arg2)
    except Exception, e:
        print type(e)
        print e

#raiseException()

        
