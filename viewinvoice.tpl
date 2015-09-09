<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="content-type" content="text/html; charset={$charset}" />
    <title>{$companyname} - {* This code should be uncommented for EU companies using the sequential invoice numbering so that when unpaid it is shown as a proforma invoice {if $status eq "Paid"}*}{$LANG.invoicenumber}{*{else}{$LANG.proformainvoicenumber}{/if}*}{$invoicenum}</title>

    <link href="templates/{$template}/invoice/css/bootstrap.min.css" rel="stylesheet">
    <link href="templates/{$template}/static/css/invoice.css" rel="stylesheet">

  </head>

  <body>

<div class="wrapper">

{if $error}

    <div class="alert alert-danger">{$LANG.invoiceserror}</div>

{else}

<table class="header">
    <tr>
        <td width="50%" nowrap>
            <p><img src="templates/{$template}/invoice/img/logo.png" title="{$companyname}" width="200"/></p>
        </td>
        <td width="50%" align="right"> 
            
            <div class="text-right">
                <span class="title">{* This code should be uncommented for EU companies using the sequential invoice numbering so that when unpaid it is shown as a proforma invoice {if $status eq "Paid"}*}{$LANG.invoicenumber}{*{else}{$LANG.proformainvoicenumber}{/if}*}{$invoicenum}</span>
                <br />
                {$LANG.invoicesdatecreated}: {$datecreated}<br />
                {$LANG.invoicesdatedue}: {$datedue}
            </div>

            {if $status eq "Unpaid"}
                <font class="unpaid">{$LANG.invoicesunpaid}</font><br />
            {if $allowchangegateway}
                <form method="post" action="{$smarty.server.PHP_SELF}?id={$invoiceid}">{$gatewaydropdown}</form>
            {else}
            {$paymentmethod}<br />
            {/if}
            {$paymentbutton}
            {elseif $status eq "Paid"}
            <font class="paid">{$LANG.invoicespaid}</font><br />
            {$paymentmethod}<br />
            ({$datepaid})
            {elseif $status eq "Refunded"}
            <font class="refunded">{$LANG.invoicesrefunded}</font>
            {elseif $status eq "Cancelled"}
            <font class="cancelled">{$LANG.invoicescancelled}</font>
            {elseif $status eq "Collections"}
            <font class="collections">{$LANG.invoicescollections}</font>
            {/if}

        </td>
    </tr>
</table>

{if $smarty.get.paymentsuccess}
<p align="center" class="paid">{$LANG.invoicepaymentsuccessconfirmation}</p>
{elseif $smarty.get.pendingreview}
<p align="center" class="paid">{$LANG.invoicepaymentpendingreview}</p>
{elseif $smarty.get.paymentfailed}
<p align="center" class="unpaid">{$LANG.invoicepaymentfailedconfirmation}</p>
{elseif $offlinepaid}
<p align="center" class="refunded">{$LANG.invoiceofflinepaid}</p>
{/if}

{if $manualapplycredit}
<form method="post" action="{$smarty.server.PHP_SELF}?id={$invoiceid}">
<input type="hidden" name="applycredit" value="true" />
<div class="creditbox">
{$LANG.invoiceaddcreditdesc1} {$totalcredit}. {$LANG.invoiceaddcreditdesc2}<br />
{$LANG.invoiceaddcreditamount}: <input type="text" name="creditamount" size="10" value="{$creditamount}" /> <input type="submit" value="{$LANG.invoiceaddcreditapply}" />
</div>
</form>
{/if}

<table class="table table-bordered">
    <tr>
        <td width="50%">
            <div class="addressbox">
                <strong>{$LANG.invoicesinvoicedto}</strong><br />
                {if $clientsdetails.companyname}{$clientsdetails.companyname}<br />{/if}
                {$clientsdetails.firstname} {$clientsdetails.lastname}<br />
                {$clientsdetails.address1}, {$clientsdetails.address2}<br />
                {$clientsdetails.city}, {$clientsdetails.state}, {$clientsdetails.postcode}<br />
                {$clientsdetails.country}
                {if $customfields}
                <br /><br />
                {foreach from=$customfields item=customfield}
                {$customfield.fieldname}: {$customfield.value}<br />
                {/foreach}
                {/if}
            </div>

        </td>
        <td width="50%">

            <div class="addressbox">

                <strong>{$LANG.invoicespayto}</strong><br />
                {$payto}

            </div>

        </td>
    </tr>
</table>

<table class="items table table-bordered">
    <tr class="title text-center">
        <td width="auto">{$LANG.invoicesdescription}</td>
        <td width="100">{$LANG.invoicesamount}</td>
    </tr>
    <tbody>
        {foreach from=$invoiceitems item=item}
            <tr>
                <td>{$item.description}{if $item.taxed eq "true"} *{/if}</td>
                <td class="text-right">{$item.amount}</td>
            </tr>
        {/foreach}
            <tr class="title">
                <td class="text-right">{$LANG.invoicessubtotal}:</td>
                <td class="text-right">{$subtotal}</td>
            </tr>
            {if $taxrate}
            <tr class="title">
                <td class="text-right">{$taxrate}% {$taxname}:</td>
                <td class="text-right">{$tax}</td>
            </tr>
            {/if}
            {if $taxrate2}
            <tr class="title">
                <td class="text-right">{$taxrate2}% {$taxname2}:</td>
                <td class="text-right">{$tax2}</td>
            </tr>
            {/if}
            <tr class="title">
                <td class="text-right">{$LANG.invoicescredit}:</td>
                <td class="text-right">{$credit}</td>
            </tr>
            <tr class="title">
                <td class="text-right">{$LANG.invoicestotal}:</td>
                <td class="text-right">{$total}</td>
            </tr>

    </tbody>
</table>

{if $taxrate}<p>* {$LANG.invoicestaxindicator}</p>{/if}

<div class="row">
<span class="subtitle">{$LANG.invoicestransactions}</span>
</div>

<table class="items table table-bordered">
    <tr class="title text-right">
        <td width="30%">{$LANG.invoicestransdate}</td>
        <td width="25%">{$LANG.invoicestransgateway}</td>
        <td width="25%">{$LANG.invoicestransid}</td>
        <td width="20%">{$LANG.invoicestransamount}</td>
    </tr>
{foreach from=$transactions item=transaction}
    <tr>
        <td class="text-right">{$transaction.date}</td>
        <td class="text-right">{$transaction.gateway}</td>
        <td class="text-right">{$transaction.transid}</td>
        <td class="text-right">{$transaction.amount}</td>
    </tr>
{foreachelse}
    <tr>
        <td class="text-right" colspan="4">{$LANG.invoicestransnonefound}</td>
    </tr>
{/foreach}
    <tr class="title">
        <td class="text-right" colspan="3">{$LANG.invoicesbalance}:</td>
        <td class="text-right">{$balance}</td>
    </tr>
</table>

{if $notes}
<p>{$LANG.invoicesnotes}: {$notes}</p>
{/if}

{/if}

</div>

<p align="center"><a href="clientarea.php">{$LANG.invoicesbacktoclientarea}</a> | <a href="dl.php?type=i&amp;id={$invoiceid}">{$LANG.invoicesdownload}</a> | <a href="javascript:window.close()">{$LANG.closewindow}</a></p>

</body>
</html>