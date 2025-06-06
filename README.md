# PostgreSQL: মূল ধারণা ও অ্যাগ্রিগেট ফাংশনগুলোর ব্যাখ্যা

## 1. PostgreSQL কী?

PostgreSQL হল একটি শক্তিশালী, ওপেন সোর্স অবজেক্ট-রিলেশনাল ডেটাবেস ম্যানেজমেন্ট সিস্টেম (RDBMS)। এটি বিশ্বের সবচেয়ে উন্নত ওপেন সোর্স ডেটাবেসগুলির মধ্যে একটি হিসেবে পরিচিত।

### মূল বৈশিষ্ট্য:

* ACID Compliance: PostgreSQL সম্পূর্ণ ACID (Atomicity, Consistency, Isolation, Durability) সমর্থন করে, যা ডেটার নির্ভরযোগ্যতা নিশ্চিত করে।

* Advanced Data Types: এটি JSON, JSONB, Array, XML, UUID, এবং কাস্টম ডেটা টাইপ সমর্থন করে।

* Extensibility: আপনি নিজস্ব ফাংশন, অপারেটর এবং ডেটা টাইপ তৈরি করতে পারেন।

* Concurrency: Multi-Version Concurrency Control (MVCC) ব্যবহার করে উচ্চ পারফরমেন্স নিশ্চিত করে।

### সুবিধাসমূহ:

* বিনামূল্যে এবং ওপেন সোর্স
* ক্রস-প্ল্যাটফর্ম (Windows, Linux, macOS)
* উচ্চ পারফরমেন্স এবং স্কেলেবিলিটি
* শক্তিশালী সিকিউরিটি ফিচার
* SQL স্ট্যান্ডার্ড কমপ্লায়েন্ট
* NoSQL ক্ষমতা (JSON সমর্থনের মাধ্যমে)

## 2. PostgreSQL-এ ডেটাবেজ স্কিমার উদ্দেশ্য কী?

ডেটাবেজ স্কিমা হলো ডেটাবেজের গঠন বা স্ট্রাকচারের একটি রূপরেখা। PostgreSQL-এ স্কিমা ব্যবহার করে আমরা এক ডেটাবেজের মধ্যে আলাদা আলাদা লজিকাল গ্রুপ তৈরি করতে পারি।

উদাহরণ:
যেমন একটি ডেটাবেজে আমাদের আছে HR ডিপার্টমেন্ট ও Accounts ডিপার্টমেন্টের তথ্য। আমরা চাইলে `hr` ও `accounts` নামে দুটি স্কিমা তৈরি করে আলাদা টেবিল রাখতে পারি, যেগুলোর নাম এক হলেও সমস্যা হবে না। যেমন:

* hr.employees
* accounts.employees

স্কিমা ব্যবহারে ডেটা সংগঠিত ও নিরাপদ রাখা সহজ হয়। এতে ব্যবহারকারীভিত্তিক পারমিশনও সহজে কনফিগার করা যায়।

## 3. Primary Key ও Foreign Key কী এবং PostgreSQL-এ কীভাবে কাজ করে?

### Primary Key:

Primary key একটি টেবিলের এমন একটি কলাম (বা কলামসমষ্টি) যা প্রতিটি রেকর্ডকে ইউনিকভাবে চিহ্নিত করে। এর মান কখনো null হয় না এবং একই মান পুনরাবৃত্তিও হয় না।

```sql
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100)
);
```

### Foreign Key:

Foreign key অন্য একটি টেবিলের primary key এর সাথে সম্পর্ক স্থাপন করে। এর মাধ্যমে দুটি টেবিলের মধ্যে রিলেশন তৈরি হয়।

```sql
CREATE TABLE results (
  id SERIAL PRIMARY KEY,
  student_id INT REFERENCES students(id),
  score INT
);
```

এখানে `results` টেবিলের `student_id` কলামটি `students` টেবিলের `id` কলামের সাথে যুক্ত। ফলে `results`-এ এমন কোনো `student_id` প্রবেশ করানো যাবে না, যা `students` টেবিলে নেই।

## 4. VARCHAR ও CHAR ডেটা টাইপের মধ্যে পার্থক্য কী?

* **VARCHAR(n):** এটি একটি ভ্যারিয়েবল-লেংথ ডেটা টাইপ। মানে, আপনি যদি VARCHAR(50) দেন এবং ৫ অক্ষরের কিছু রাখেন, তাহলে শুধুমাত্র সেই ৫ অক্ষর সংরক্ষিত হবে। বাকি স্পেস অপচয় হবে না।
* **CHAR(n):** এটি একটি ফিক্সড-লেংথ ডেটা টাইপ। CHAR(50) দিলে আপনি যদি মাত্র ৫ অক্ষরের কিছু দেন, তাও পুরো ৫০টি স্পেস সংরক্ষণ করবে। বাকি স্থানগুলোতে padding হিসেবে স্পেস বসবে।

**সাধারণত VARCHAR বেশি ব্যবহারযোগ্য কারণ এটি মেমরি অপচয় কম করে।**

## 5. SELECT স্টেটমেন্টে WHERE ক্লজের উদ্দেশ্য কী?

`WHERE` ক্লজ ব্যবহার করে আমরা ডেটা ফিল্টার করতে পারি। অর্থাৎ, শুধু যেসব রেকর্ড একটি নির্দিষ্ট শর্ত পূরণ করে, সেগুলোই রিটার্ন করা হয়।

উদাহরণ:

```sql
SELECT * FROM students WHERE score > 80;
```

এখানে `score` ৮০-এর বেশি এমন ছাত্রদের তথ্য দেখাবে।

`WHERE` ছাড়া সব ডেটা দেখাবে যা অনেক সময় অপ্রয়োজনীয় এবং সিস্টেম স্লো করে দিতে পারে।

## 6. LIMIT ও OFFSET কী কাজে ব্যবহার হয়?

* **LIMIT:** রেজাল্ট থেকে কতটি রেকর্ড চাই, তা নির্ধারণ করে।
* **OFFSET:** কতগুলি রেকর্ড স্কিপ করবে, তা নির্ধারণ করে।

```sql
SELECT * FROM students LIMIT 10 OFFSET 20;
```

এই কোয়্যারিতে ২১তম থেকে শুরু করে পরবর্তী ১০টি রেকর্ড দেখাবে। এটি Pagination এর জন্য খুবই দরকারী।

## 7. UPDATE স্টেটমেন্ট দিয়ে কীভাবে ডেটা পরিবর্তন করা যায়?

`UPDATE` ব্যবহার করে টেবিলের ডেটা পরিবর্তন করা যায়। সঙ্গে `WHERE` ক্লজ ব্যবহার না করলে সব রেকর্ড আপডেট হয়ে যাবে, যা বিপজ্জনক।

```sql
UPDATE students SET score = 100 WHERE id = 1;
```

এখানে `id = 1` এমন স্টুডেন্টের নতুন `score` হবে ১০০।

## 8. JOIN অপারেশনের গুরুত্ব কী এবং এটি কীভাবে কাজ করে?

`JOIN` ব্যবহার করে একাধিক টেবিলের তথ্য একত্রে এনে কাজ করা যায়। এটি রিলেশনাল ডেটাবেজের অন্যতম গুরুত্বপূর্ণ অংশ। PostgreSQL-এ বিভিন্ন ধরনের JOIN আছে:

* **INNER JOIN:** শুধু মিল থাকা রেকর্ডগুলো ফেরত দেয়।
* **LEFT JOIN:** বাম টেবিলের সব রেকর্ড দেখায়, ডান পাশে মিল না থাকলে null দেয়।
* **RIGHT JOIN:** ডান পাশের সব রেকর্ড, বাম পাশে মিল না থাকলে null।
* **FULL JOIN:** উভয় টেবিলের সব রেকর্ড, মিল না থাকলে null।

```sql
SELECT s.name, r.score
FROM students s
JOIN results r ON s.id = r.student_id;
```

## 9. GROUP BY ক্লজ কী এবং এটি অ্যাগ্রিগেশন অপারেশনে কী ভূমিকা রাখে?

`GROUP BY` ক্লজ ব্যবহার করে আমরা ডেটাকে নির্দিষ্ট কলাম বা কলামসমূহের ভিত্তিতে গ্রুপ করি। এরপর প্রতিটি গ্রুপের জন্য আলাদা আলাদা অ্যাগ্রিগেট ফাংশন (যেমন COUNT(), SUM(), AVG()) প্রয়োগ করতে পারি। এটি মূলত ডেটাকে ক্যাটাগরি বা শ্রেণি অনুসারে ভাগ করে হিসাব করার জন্য ব্যবহৃত হয়।

উদাহরণ:

```sql
SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY department;

```

এখানে `employees` টেবিল থেকে প্রতিটি `department`-এর মোট কর্মচারীর সংখ্যা বের করা হচ্ছে। ফলাফল হবে department অনুযায়ী কর্মচারীর সংখ্যা।

আরেকটি উদাহরণ:
```sql
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department;

```
এখানে প্রতিটি department-এর গড় বেতন বের করা হচ্ছে।

## 10. PostgreSQL-এ COUNT(), SUM(), এবং AVG() এর মত অ্যাগ্রিগেট ফাংশন কীভাবে কাজ করে?

* **COUNT():** কতটি রেকর্ড আছে তা গণনা করে।
উদাহরণ: SELECT COUNT(*) FROM students; → এটি students টেবিলের মোট রেকর্ড সংখ্যা (মোট ছাত্র সংখ্যা) দেখাবে।


* **SUM():** নির্দিষ্ট কলামের সকল মান যোগ করে।
  উদাহরণ: SELECT SUM(score) FROM results; → এটি results টেবিলের সব score এর যোগফল দেখাবে। যেমন যদি স্কোর হয় 80, 90, 70 → ফলাফল হবে 240।


* **AVG():** নির্দিষ্ট কলামের গড় মান বের করে।
  উদাহরণ: SELECT AVG(score) FROM results; → এটি score এর গড় মান দেখাবে। যেমন (80 + 90 + 70) / 3 = 80।

```sql
SELECT COUNT(*) FROM students;
SELECT SUM(score) FROM results;
SELECT AVG(score) FROM results;
```



