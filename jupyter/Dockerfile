FROM ivonet/py3:latest

RUN pip install jupyter

WORKDIR /project
EXPOSE 8888

CMD ["jupyter", "notebook", "--port=8888", "--ip=0.0.0.0", "--allow-root"]