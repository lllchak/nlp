FROM python:3-alpine3.8 as tokenizers

WORKDIR /project
COPY . .

LABEL "project"="tokenizers_tests"
LABEL "author"="lllchak"

RUN apk add --no-cache --virtual .build-deps \
    build-base openssl-dev libffi-dev

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

ENTRYPOINT [ "python" ]
CMD [ "tecode/tokenizers/tokenizers_tests.py" ]

FROM python:3-alpine3.8 as vectorizers

WORKDIR /project
COPY . .

LABEL "project"="vectorizers_tests"
LABEL "author"="lllchak"

RUN apk add --no-cache --virtual .build-deps \
    build-base openssl-dev libffi-dev

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

ENTRYPOINT [ "python" ]
CMD [ "tecode/vectorizers/vectorizers_tests.py" ]

FROM python:3-alpine3.8 as all

WORKDIR /project
COPY . .

LABEL "project"="vectorizers_tests"
LABEL "author"="lllchak"

RUN apk add --no-cache --virtual .build-deps \
    build-base openssl-dev libffi-dev

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . /.scripts/test_all.sh
RUN chmod a+x test_all.sh
CMD [ "./test_all.sh" ]
