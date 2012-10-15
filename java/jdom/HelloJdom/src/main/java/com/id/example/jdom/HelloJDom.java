package com.id.example.jdom;

import java.io.IOException;
import java.io.InputStream;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.jdom.output.DOMOutputter;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;

/**
 * @author idanilov
 *
 */
public class HelloJDom {

	private XMLOutputter printer;

	public static void main(String[] args) {
		HelloJDom play = new HelloJDom();
		play.parseAndPlay(HelloJDom.class.getResourceAsStream("/test.xml"));
	}

	public HelloJDom() {
		printer = new XMLOutputter();
	}

	public void parseAndPlay(InputStream is) {
		SAXBuilder parser = new SAXBuilder();
		try {
			Document doc = parser.build(is);
			this.rawPrintJDom(doc);
			
			System.out.println(doc.getRootElement().getName());
			Element firstChild = (Element) doc.getRootElement().getChildren().get(0);
			System.out.println(">> " + firstChild.getName() + ":"
					+ firstChild.getAttribute("type").getValue());
			System.out.println(">>>>" + firstChild.getText());

			//easily print
			this.prettyPrintJDom(doc);

			// do you want an classic DOM? no prob!
			DOMOutputter out = new DOMOutputter();
			org.w3c.dom.Document domDoc = out.output(doc);
			System.out.println(domDoc.getImplementation().toString());

			//lets make some changes!
			Element child = (Element) doc.getRootElement().getChildren().get(0);
			child.setName("NewNAME");
			child.setText("Water Mellon");

			//lets print in the console the altered JDomTree
			this.prettyPrintJDom(doc);
		} catch (JDOMException ex) {
			ex.printStackTrace();
		} catch (IOException ex) {
			ex.printStackTrace();
		}
	}

	public void prettyPrintJDom(Document aJDOMdoc) throws IOException {
		System.out.println("<------------ Formatted XML ------------>");
		Format f = Format.getPrettyFormat();
		//f.setIndent("    ");
		this.printer.setFormat(f);
		this.printer.output(aJDOMdoc, System.out);
	}

	public void rawPrintJDom(Document aJDOMdoc) throws IOException {
		System.out.println("<------------ Raw XML ------------>");
		Format f = Format.getRawFormat();
		this.printer.setFormat(f);
		this.printer.output(aJDOMdoc, System.out);
	}

}