## CsciBERT构建

### 创建预训练数据
- 医学领域805,636篇摘要，5,372,295句子
```bash
# cscd医学领域数据, max_seq 128, normal
python create_pretraining_data.py \
--vocab_file=models/chinese_L-12_H-768_A-12/vocab.txt \
--output_file=data/cscibert_pre_training/pre_training_R_cscd_128.tfrecord \
--input_file=data/cscibert_pre_training/Med_Source.txt \
--max_seq_length=128
```

### 医学领域预训练
- pre-training from scrach
```bash
::Pre1_cscd_R_128_from_scrach 128
python run_pretraining.py^
 --input_file data/cscibert_pre_training/pre_training_R_cscd_128.tfrecord^
 --bert_config_file models/chinese_L-12_H-768_A-12/bert_config.json^
 --output_dir outputs/Pre1_cscd_R_128_from_scrach^
 --max_seq_length 128^
 --do_train True^
 --train_batch_size 32^
 --learning_rate 2e-5^
 --num_train_steps 1000000^
 --gpu 0^
```
- pre-training from bert
```bash
::Pre1_cscd_R_128_from_bert 128
python run_pretraining.py^
 --input_file data/cscibert_pre_training/pre_training_R_cscd_128.tfrecord^
 --bert_config_file models/chinese_L-12_H-768_A-12/bert_config.json^
 --init_checkpoint models/chinese_L-12_H-768_A-12/bert_model.ckpt^
 --output_dir outputs/Pre2_cscd_R_128_from_bert^
 --max_seq_length 128^
 --do_train True^
 --train_batch_size 32^
 --learning_rate 2e-5^
 --num_train_steps 200000^
 --gpu 1^
```

### 科技文献中图法二级分类

- 中图法二级分类数据

    按cscd网站二级分类，统计全部的二级类共计87个
    
    ```
    work\cla_data_stat\cla_cscd.txt
    
    C 社会科学总论
    N91 自然科学研究、自然历史
    N93 非线性科学
    N94 系统科学
    O1 数学
    O3 力学
    O4 物理学
    O6 化学
    O7 晶体学
    P1 天文学
    P2 测绘学
    P3 地球物理学
    P4 大气科学（气象学）
    P5 地质学
    P7 海洋学
    ...
    ```
    对各领域数据进行统计，work/cla_data_stat/cscd_cla_stats.py
    ```
    cla_cscd_stat_uni.txt
    
    C 社会科学总论	4283
    N91 自然科学研究、自然历史	45
    N93 非线性科学	47
    N94 系统科学	1890
    O1 数学	18574
    O3 力学	11793
    O4 物理学	27587
    O6 化学	61227
    O7 晶体学	2102
    P1 天文学	2272
    P2 测绘学	17842
    P3 地球物理学	13480
    P4 大气科学（气象学）	16004
    ...
    ```
    
    去掉几个数量过少的类
    ```
    N91 自然科学研究、自然历史	45
    N93 非线性科学	47
    R79 外国民族医学	112
    U1 综合运输	657
    V1 航空、航天技术的研究与探索	502
    Q98 人类学	451
    
    
  
    ``` 
    得到 work/cla_data_stat/cla_cscd_filter_1/cla_cscd_filter.txt ，共计81个类
    
    创建一个测试集，每个类取前100
    ```
     sql = "insert into cla_test_100 SELECT top 100 * FROM article_info where classification like '{cla_str}%' and isUniCla=1 and language='chi'".format(
            cla_str=label)
    ```
    人工筛选，每个类得到50条测试数据，共计4050条测试集。
       
 
- 二级分类结果


### CSCD物理学分类

- 数据整理
    
    统计各类别数据
    
    共计21120







