import express, { Request } from 'express';
const bodyParser = require('body-parser');
import { config } from 'dotenv';
import os from 'os';
const SDC = require('statsd-client');
const path = require('path')
config({path : path.resolve(__dirname , '../.env') });


// init
const port: string = process.env.APP_PORT || `3033`;
const hostName = os.hostname();
const metricPrefix = process.env.SERVER_ID || `server_${hostName}`;


const app = express();
app.use(bodyParser.json());
const statsd = new SDC({
    host: process.env.STATSD_HOST,
    port: process.env.STATSD_PORT
});


// test-api
app.post("/statsd-poc", (req: Request, res) => {
    const { body } = req;

    // get from body or generate in code
    const finalTiming = (body && body.inputTiming && !isNaN(body.inputTiming)) ? +body.inputTiming : getRandomNumber();
    const finalTimingSrc = (body && body.inputTiming && !isNaN(body.inputTiming)) ? "body" : "getRandomNumber";

    // increment counter metric
    statsd.increment(`${metricPrefix}.${process.env.STATSD_SAMPLE_TIMER_METRIC}`);

    // send a timer metric , pick a random number as the timer
    statsd.timing(`${metricPrefix}.${process.env.STATSD_SAMPLE_COUNT_METRIC}`, finalTiming);

    // response
    console.log(`api : hostName=[${hostName}] , finalTiming=[${finalTiming}] , finalTimingSrc=[${finalTimingSrc}]`);
    res.json({ hostName, metricPrefix , finalTiming , finalTimingSrc});
});

app.listen(port, async () => {
    console.log(`server started on port=[${port}] , hostName=[${hostName}] , metricPrefix=[${metricPrefix}]`);
});


function getRandomNumber(): number {
    const min = process.env.MIN_TIMER_NUMBER!;
    const max = process.env.MAX_TIMER_NUMBER!;
    const randomNumber = Math.floor(Math.random() * (+max - +min + 1)) + (+min);
    return randomNumber;
}