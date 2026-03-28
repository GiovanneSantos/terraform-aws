import invoices from "./invoices.json" with {type: 'json'} ;
import plays from "./plays.json" with {type: 'json'};

function Statement (invoices, plays){
    let totalAmount = 0;
    let volumeCredits = 0;
    let result = `Statment for ${invoices.customer}\n`;

    const format = new Intl.NumberFormat("en-US",
        { style: "currency", currency: "USD",
        minimumFractionDigits: 2 }).format;

    for (let perf of invoices.performances) {
        let thisAmount = 0;
        const play = plays[perf.playId];
        switch (play.type) {
            case "tragedy":
                thisAmount = 4000;
                if(perf.audience > 30) {
                    thisAmount += 1000 * (perf.audience - 30);
                }
                break;

            case "comedy":
                thisAmount = 3000;
                if (perf.audience > 20) {
                    thisAmount += 1000 + 500 * (perf.audience - 20);
                }
                thisAmount += 300 * perf.audience;
                break;

            default:
                throw new Error(`unknown type: ${play.type}`);
        }

        // soma créditos por volume
        volumeCredits += Math.max(perf.audience - 30, 0);

        // soma um crédito extra para cada dez espectadores de comédia
        if ("comedy" === play.type) {
            volumeCredits += Math.floor(perf.audience / 5);
        }

        // exibe a linha
        result += ` ${play.name}: ${format(thisAmount/100)} (${perf.audience} seats)\n`;
        totalAmount += thisAmount;
    }

    result += `Amount owed is ${format(totalAmount/100)}\n`;
    result += `You earnd ${volumeCredits} credits\n`;

    return result;
}

function main(){
    console.log(Statement (invoices, plays));
}

main();