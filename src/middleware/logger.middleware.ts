import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';
import { createLogger, transports, format } from 'winston';
import * as DailyRotateFile from 'winston-daily-rotate-file';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
@Injectable()
export class LoggerMiddleware implements NestMiddleware {
    private logger;
    constructor() {
        const logFormat = format.printf(
            ({ level, message, timestamp }) =>
                `${timestamp} ${level}: ${message}`,
        );

        const transport = new (DailyRotateFile as any)({
            filename: 'logs/application-%DATE%.log',
            datePattern: 'YYYY-MM-DD',
            zippedArchive: true,
            maxSize: '20m',
            maxFiles: '14d',
        })
        this.logger = createLogger({
            level: 'info',
            format: format.combine(format.timestamp(), logFormat),
            transports: [
                transport,
                new transports.Console(), // Optionally log to console
            ],
        });
    }


    use(req: Request, res: Response, next: NextFunction) {

        res.header('Access-Control-Allow-Origin', '*');
        res.header(
            'Access-Control-Allow-Methods',
            'GET, POST, PUT, DELETE, OPTIONS',
        );
        res.header(
            'Access-Control-Allow-Headers',
            'Origin, X-Requested-With, Content-Type, Accept',
        );
        const { method, originalUrl: url, ip } = req;
        const userAgent = req.get('user-agent') || '';

        res.on('finish', () => {
            const { statusCode } = res;
            const contentLength = res.get('content-length');

            const logEntry = `${method} ${url} ${statusCode} ${contentLength} - ${userAgent} ${ip}`;

            this.logger.info(logEntry);
        });

        next();
    }
}
