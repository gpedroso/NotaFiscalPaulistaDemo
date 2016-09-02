from lxml import html
import codecs
import re
import os
import csv


def readInvoice(html_invoice, invoice):
    marketName = ''.join(html_invoice.xpath('//*[@id="dadosCabecalhoCF"]/tbody/tr[1]/td/text()'))

    dataShoppingList = html_invoice.xpath('//*[@id="dadosCorpoCF"]/table[1]/tbody/tr/td[1]/text()')
    dataShoppingStr = ''.join(dataShoppingList)
    match=re.search(r'(\d+/\d+/\d+)', dataShoppingStr)
    dataShopping = match.group(1)

    totalItemTables = html_invoice.xpath('count(//*[@id="painelItens"]/table)')
    # invoice = []

    for i in range(1, int(totalItemTables)):
        product = html_invoice.xpath('//*[@id="painelItens"]/table['+str(i)+']/tbody/tr[1]/td[3]/text()')
        productPrice = html_invoice.xpath('//*[@id="painelItens"]/table['+str(i)+']/tbody/tr[2]/td[3]/text()')
        productQuantity = html_invoice.xpath('//*[@id="painelItens"]/table['+str(i)+']/tbody/tr[2]/td[2]/text()')
        productTotal = html_invoice.xpath('//*[@id="painelItens"]/table['+str(i)+']/tbody/tr[2]/td[5]/text()')
        invoiceItem = []
        invoiceItem.append(marketName)
        invoiceItem.append(dataShopping)
        invoiceItem.append(''.join(product))
        invoiceItem.append(float(''.join(productPrice).replace(",",".")))
        invoiceItem.append(float(''.join(productQuantity).replace(" x","").replace(" ","").replace(",",".")))
        invoiceItem.append(float(''.join(productTotal).replace(",",".")))
        invoice.append(invoiceItem)

    return invoice

list_invoice = []

# f=codecs.open("notas/Cupom_20160702.html", 'r').read()
# html_invoice = html.fromstring(f)
# list_invoice =  readInvoice(html_invoice, list_invoice)
#
#
# f=codecs.open("notas/Cupom_20160720.html", 'r').read()
# html_invoice = html.fromstring(f)
# list_invoice =  readInvoice(html_invoice, list_invoice)
#
# f=codecs.open("notas/Cupom_20160724.html", 'r').read()
# html_invoice = html.fromstring(f)
# list_invoice =  readInvoice(html_invoice, list_invoice)

#for inv in list_invoice:
#    print(inv)

for file in os.listdir("notas"):
    if file.endswith(".html"):
        f=codecs.open("notas/"+file, 'r').read()
        html_invoice = html.fromstring(f)
        list_invoice = readInvoice(html_invoice, list_invoice)

for inv in list_invoice:
    print(inv)

with open("notas.csv", "w") as f:
    writer = csv.writer(f, delimiter=' ',quotechar='|', quoting=csv.QUOTE_ALL)
    writer.writerows(list_invoice)