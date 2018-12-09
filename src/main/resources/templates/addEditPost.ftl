<#--@ftlvariable name="comment" type="com.fonarik94.domain.Comment"-->
<#--@ftlvariable name="post" type="com.fonarik94.domain.Post"-->
<#import "/spring.ftl" as spring/>
<#import "parts/common.ftl" as c>
<@c.commonTemplate>
<script type="text/javascript" src="/resources/js/jquery-fileupload/vendor/jquery.ui.widget.js"></script>
<script type="text/javascript" src="/resources/js/jquery-fileupload/jquery.fileupload.js"></script>
<script type="text/javascript" src="/resources/js/jquery-fileupload/jquery.fileupload-ui.js"></script>
<script type="text/javascript" src="/resources/js/jquery-fileupload/jquery.iframe-transport.js"></script>
<div class="col-xl-6  p-1">
    <div class="card p-3 m-2 shadow">
        <form id="editor" method="post" accept-charset="UTF-8">
        <@spring.bind "post"/>
            <div class="form-group">
                <label for="headerInput">Заголовок</label>
            <@spring.formInput "post.header", 'class="form-control" name="headerInput"'/>
            </div>
            <div class="form-group">
                <label for="text">Текст поста</label>
            <@spring.formTextarea "post.text",'class="form-control" id="text" rows=20 name="text"'/>
            </div>

            <@spring.formHiddenInput "post.id", 'value=${post.id}'/>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <div class="checkbox">
                <label for="published">
                <@spring.formCheckbox "post.published"/>Опубликовано
                </label>
            </div>
            <div>
                <input type="submit" class="btn btn-primary" value="Сохранить">
            </div>
        </form>

        <form class="form-inline" id="uploadImg" method="post" action="/administration/postwriter/upload" enctype="multipart/form-data">
            <div class="form-group">
                <label for="image-upload">Загрузите изображения</label>
                <input class="form-control-file" id="image-upload" type="file" accept="image/*" name="file" multiple>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </div>
            <input class=" btn btn-primary" type="submit" value="Загрузить">
        </form>
    </div>

    <div class="card p-3 m-2 shadow">
    <#if post.comments?has_content>
        <#list post.comments as comment>
            <div class="comment" id=${comment.getId()}>
                <h5>${comment.author}</h5>
                <h6 class="card-subtitle text-muted mb-2">
                    ${comment.getPublicationDateAsString()}
                </h6>
                <p>${comment.text}</p>
                <div class="btn btn-danger" onclick="deleteComment(${comment.id})">
                    Удалить
                </div>
            </div>
            <#sep >
                <hr>
        </#list>
    <#else>
            <p>Коментариев пока нет</p>
    </#if>
    </div>
</div>
    <div class="col-xl-6 p-1">
        <div class="card p-3 m-2 shadow" id="preview"></div>
    </div>
<script defer>
    function doLivePreview() {
        $("#preview").html($("#text").val());
    }

    $(function () {
        doLivePreview();
        $("#text").on("input", doLivePreview);
    });

    $(document).ready(function () {
        uploadImage();
    })
</script>

</@c.commonTemplate>