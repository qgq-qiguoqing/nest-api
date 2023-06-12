// redirect.middleware.ts

import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';

@Injectable()
export class RedirectMiddleware implements NestMiddleware {

    use(req: Request, res: Response, next: NextFunction) {
        const originalUrl = req.originalUrl;
        const redirectedUrl = originalUrl.replace('/blog', ':3000',);
        return res.redirect(301, redirectedUrl);
    }
}
