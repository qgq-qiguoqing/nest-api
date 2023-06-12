import {
    Column,
    Entity,
    PrimaryGeneratedColumn,

} from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';

@Entity('classification')
export class Classification {

    @PrimaryGeneratedColumn()
    id: number; // 标记为主键，值自动生成

    @Column()
    nameID: string
    @ApiProperty({
        description: "分类名称"
    })
    @Column()
    name: string

    @ApiProperty({
        description: "创建时间"
    })
    @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
    createTime: Date;
}
