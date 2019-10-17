// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
// (function() {
//     $(function() {
//         var selectForms = document.getElementsByName('point');

//         for(var i=0, len=selectForms.length; i < len; i++) {
//             selectForms.item(i).addEventListener('change', function() {
//                 var selectVal = this.value;
//                 var questionId = this.getAttribute('data-question');
//                 var questionItemId = this.getAttribute('data-question-item');
//                 // console.log(question);
//                 // console.log(questionItem);
//                 // console.log(selectVal);

//                 // csrf_tokenに関する記述
//                 $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
//                     var token;
//                     if (!options.crossDomain) {
//                     token = $('meta[name="csrf-token"]').attr('content');
//                     if (token) {
//                         return jqXHR.setRequestHeader('X-CSRF-Token', token);
//                     }
//                     }
//                 });

//                 // 非同期処理
//                 $.ajax({
//                     type:'PATCH',
//                     url:"/questionnaire/item/update",
//                     data: {
//                         point: selectVal,
//                         question_id: questionId,
//                         question_item_id: questionItemId
//                     },
//                     dataType:'json'
//                 }).done(function(data) {
//                     console.log(data);
//                     var itemIdName = "item_points_%json".replace("%json", data.questionnaire_item.id);
//                     var allPointIdName = "all_point_%json".replace("%json", data.questionnaire_item.id);
//                     console.log(itemIdName);
//                     console.log(allPointIdName);
//                     var selectTag = document.getElementById(itemIdName);
//                     var allPoint = document.getElementById(allPointIdName);

//                     selectTag.value = data.user_questionnaire.point;
//                     allPoint.textContent = data.all_point;
//                 }).fail(function(data) {
//                     alert('更新に失敗しました。');
//                 });
//             });
//         }
//     });
// })();