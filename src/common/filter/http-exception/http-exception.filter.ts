import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,

} from '@nestjs/common';
import { Request, Response } from 'express';
import { ApiException } from './api.exception';
@Catch(HttpException)
export class HttpExceptionFilter implements ExceptionFilter {
  catch(exception: HttpException, host: ArgumentsHost) {
    const s = {
      200: 0,
      401: 1,
      400: -1,
      500: -1
    }
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request>();
    const status = exception.getStatus();

    if (exception instanceof ApiException) {

      response.status(status).json({
        status: exception.getErrorCode() in s ? s[status] : exception.getErrorCode(),
        timestamp: new Date().toISOString(),
        // path: request.url,
        msg: exception.getErrorMessage(),
      });
      return;
    }

    response.status(status).json({
      status: exception.message ? -1 : status in s ? s[status] : status,
      timestamp: new Date().toISOString(),
      // path: request.url,
      msg: exception.message,
    });
  }
}

