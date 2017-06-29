<?php
require_once('./selectDb.php');
require_once('./insertDb.php');
$date = date("Y-m-d H:i:s", time());
$sql = "SELECT
	business_partner.client_type,
	business_partner.business_key,
	business_partner.business_name,
	business_partner.business_level,
	business_partner.business_type,
	business_partner.is_supplier,
	business_partner.is_customer,
	business_partner.group_id,
	business_partner.province_id,
	business_partner.city_id,
	business_partner.area_id,
	business_partner.detail_addr,
	business_partner.worker_id,
	business_partner.organization_id,
	business_partner.department_id,
	business_partner.account_id,
	business_partner.is_confirm,
	business_partner.is_public,
	business_partner.remark,
	business_demand.product_code,
	t.username,
	t.mobile,
	t.tel,
	business_partner_access.`status`,
	business_partner_access.`protect_time`,
	business_partner_access.`expired_time`,
	business_information.key_no,
	business_information.oper_name,
	business_information.start_date,
	business_information.end_date,
	business_information.term_start,
	business_information.team_end,
	business_information.check_date,
	business_information.`status` AS info_status,
	business_information.belong_org,
	business_information.province,
	business_information.updated_date,
	business_information.credit_code,
	business_information.regist_no,
	business_information.regist_capi,
	business_information.econ_kind,
	business_information.address,
	business_information.scope,
	business_information.is_real,
	worker.realname
    FROM
        business_partner
    LEFT JOIN business_information ON business_information.`name` = business_partner.business_name
    LEFT JOIN business_demand ON business_demand.business_id = business_partner.id
    LEFT JOIN (
        SELECT
            username,
            mobile,
            tel,
            business_partner_id
        FROM
            business_contacts
        ORDER BY
            create_time
        LIMIT 1
    ) AS t ON t.business_partner_id = business_partner.id
    LEFT JOIN business_partner_access ON business_partner_access.partner_id = business_partner.id
    LEFT JOIN worker ON worker.id = business_partner.create_uid
    WHERE
        business_partner.is_confirm = 1
    AND business_partner.is_rsync = 0";

try {
    $select_connect = selectDb::getInstance()->connect();
    $insert_connect = insertDb::getInstance()->connect();
} catch (Exception $e) {
    // $e->getMessage();
    file_put_contents('./logs/' . date('y-m-d') . '.txt', $e->getMessage());
    return;
}
$result = mysqli_query($select_connect, $sql);

$business_partners = array();

while ($business_partner = mysqli_fetch_assoc($result)) {
    $business_partners[] = $business_partner;
}



if(!$business_partners){
    return false;
}

foreach ($business_partners as $key => $value) {

    //查询外平台是否已经添加相同的供应商
    $is_exist_sql = "select * from business_partner where business_name = '{$value['business_name']}'";
    $insert_result = mysqli_query($insert_connect, $is_exist_sql);
    $select_result = mysqli_fetch_assoc($insert_result);
    $date = date("Y-m-d H:i:s");

    if ($select_result) {
        continue;
    } else {
        mysqli_begin_transaction();

        //插入客户表
        $insert_p_sql = "INSERT INTO business_partner" .
            "(client_type,business_key,business_name,business_level,business_type,is_supplier,is_customer,group_id,is_del,
            province_id,city_id,area_id,detail_addr,remark,worker_id,organization_id,department_id,account_id,create_uid
            ,create_time,is_confirm,is_public) " .
            "VALUES " .
            "('b','{$value['business_key']}','{$value['business_name']}','{$value['business_level']}','{$value['business_type']}','N','Y','1','N',
            '{$value['province_id']}','{$value['city_id']}','{$value['area_id']}','{$value['detail_addr']}','{$value['remark']}',
            '{$value['worker_id']}','{$value['organization_id']}','{$value['department_id']}','{$value['account_id']}','{$value['worker_id']}',
            '$date','1','{$value['is_public']}')";

        mysqli_select_db($insert_connect, 'crontab_test');
        $aa = mysqli_query($insert_connect, $insert_p_sql);
        $partner_id = mysqli_insert_id($insert_connect);
        if(!$partner_id){
            mysqli_begin_transaction()
        }

        //插入权限表

        $access_sql = "INSERT INTO business_partner_access " .
            "(worker_id,department_id,organization_id,partner_id,status,account_id,create_uid,create_time,protect_time,expired_time) " .
            "VALUES " .
            "('{$value['worker_id']}','{$value['department_id']}','{$value['organization_id']}','$partner_id','{$value['status']}',
            '{$value['account_id']}','{$value['worker_id']}','$date','{$value['protect_time']}','{$value['expired_time']}')";

        mysqli_select_db($insert_connect, 'crontab_test');
        mysqli_query($insert_connect, $access_sql);


        //插入联系人
        $contact_sql = "INSERT INTO business_contacts" .
            "(create_uid,create_time,`type`,username,mobile,tel,business_partner_id) " .
            "VALUES " .
            "('{$value['worker_id']}','$date','1','{$value['username']}','{$value['mobile']}','{$value['tel']}','$partner_id')";

        mysqli_select_db($insert_connect, 'crontab_test');
        mysqli_query($insert_connect, $contact_sql);

        //插入牌号
        $demand_sql = "INSERT INTO business_demand" .
            "(product_code,business_id,create_uid,create_time) " .
            "VALUES " .
            "('{$value['product_code']}','$partner_id','{$value['worker_id']}','$date')";

        mysqli_select_db($insert_connect, 'crontab_test');
        mysqli_query($insert_connect, $demand_sql);

        //插入工商信息
        $info_sql = "INSERT INTO business_information " .
            "(create_uid,create_time,key_no,`name`,oper_name,start_date,end_date,term_start,team_end,check_date,status,
            belong_org,province,updated_date,credit_code,regist_no,regist_capi,econ_kind,address,scope,is_real) " .
            "VALUES " .
            "('{$value['worker_id']}','$date','{$value['key_no']}','{$value['business_name']}','{$value['oper_name']}','{$value['start_date']}',
            '{$value['end_date']}','{$value['term_start']}','{$value['team_end']}','{$value['check_date']}'
            ,'{$value['info_status']}','{$value['belong_org']}','{$value['province']}','{$value['updated_date']}','{$value['credit_code']}',
            '{$value['regist_no']}','{$value['regist_capi']}','{$value['econ_kind']}','{$value['address']}','{$value['scope']}','{$value['is_real']}')";

        mysqli_select_db($insert_connect, 'crontab_test');
        mysqli_query($insert_connect, $info_sql);

        //插入日志
        $log_sql = "INSERT INTO business_change_record " .
            "(change_type,client_id,old_value,new_value,create_time,create_uid,content) " .
            "VALUES " .
            "('create','$partner_id','0','2','$date','{$value['worker_id']}','从内平台同步创建客户')";

        mysqli_select_db($insert_connect, 'crontab_test');
        mysqli_query($insert_connect, $log_sql);

        //修改内平台同步状态
        $update_sql = "update business_partner set is_rsync = 1 WHERE business_name = '{$value['business_name']}'";
        mysqli_select_db($select_connect, 'st_inner_erp');
        mysqli_query($select_connect, $update_sql);
    }
}

return;