import groovy.xml.MarkupBuilder;

log.info('------------------------------------------------------------------------')
log.info('[CONF -> XML groovy script]')
log.info('------------------------------------------------------------------------')

def prop = new Properties();
def source = new FileInputStream(new File(project.basedir, 'src/main/data/data.properties')); 
prop.load(source); 
//println prop
def config = new ConfigSlurper().parse(prop);
def keys = new TreeSet(config.keySet());
//keys.each {println it}

//format:
//<enum value="AD" category="LIST_VALUES"/>
def writer = new StringWriter();
def xml = new MarkupBuilder(writer);
xml.setDoubleQuotes(true);
xml.enums {
    keys.each {
        "enum"(value:it,category:"LIST_VALUES")
    }
}

def targetDir = new File(project.build.directory, 'generated-resources');
targetDir.mkdirs()
def target = new File(targetDir, 'data.xml')
if (target.exists()) {
    target.setWritable(true)
}
target.write('<?xml version="1.0" encoding="UTF-8" ?>\r\n')
target.append(writer.toString())

