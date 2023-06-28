import { PartialType } from '@nestjs/swagger';
import { CreateBackgroundImageDto } from './create-background-image.dto';

export class UpdateBackgroundImageDto extends PartialType(CreateBackgroundImageDto) {}
