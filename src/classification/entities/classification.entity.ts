import {
    Column,
    Entity,
    PrimaryGeneratedColumn,
    OneToMany
} from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';
import { Article } from '../../article/entities/article.entity';

@Entity('classification')
export class Classification {

    @PrimaryGeneratedColumn()
    id: number; // 标记为主键，值自动生成

    @ApiProperty({
        description: "分类Id"
    })
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

    // @OneToMany(() => Article, article => article.classification)
    // articles: Article[];
}
