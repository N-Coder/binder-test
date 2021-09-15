FROM ncoder/ogdf:v0.1.2-dev

RUN pip install --no-cache-dir jupyter jupyterlab

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
WORKDIR ${HOME}
RUN mv ogdf-python/docs/examples examples \
    && rm -rf ogdf-python \
#    && mv /opt/ogdf/doc/html ogdf-doc
#ENV OGDF_DOC_URL=http://127.0.0.1:8888/view/ogdf-doc/%s.html#%s

# TODO clone ogdf_python examples (and maybe docs), copy over OGDF doc and set OGDF_DOC_URL